#!/usr/bin/env sh
set -e

if [ "$1" = 'httpd-foreground' ]
then
  if [ ! -f /usr/local/apache2/conf/ssl/dhparam.pem ]
  then
    echo "/usr/local/apache2/conf/ssl/dhparam.pem not found, generating..."
    openssl dhparam -dsaparam -out /usr/local/apache2/conf/ssl/dhparam.pem 2048 > /dev/null 2>&1
  fi

  if [ ! -f /usr/local/apache2/conf/ssl/cert.pem ] && [ ! -f /usr/local/apache2/conf/ssl/key.pem ]
  then
    echo "/usr/local/apache2/conf/ssl/cert.pem+key.pem not found, generating self-signed cert+key"
    echo  "[req]\ndistinguished_name=dn\n[dn]\n[ext]\n"\
          "basicConstraints=critical,CA:FALSE\n"\
          "keyUsage=critical,digitalSignature,keyEncipherment\n"\
          "subjectAltName=DNS:example.com,DNS:www.example.com\n"\
          "extendedKeyUsage=critical,serverAuth,clientAuth\n" > /tmp/openssl.conf
    # rsa
    openssl req -x509 -newkey rsa:2048 -nodes -sha256 -batch \
            -days 1825 -config /tmp/openssl.conf -extensions ext \
            -keyout /usr/local/apache2/conf/ssl/key.pem -out /usr/local/apache2/conf/ssl/cert.pem \
            -subj "/C=AQ/O=Example Corp./CN=www.example.com" > /dev/null 2>&1
    # ecdsa
    if [ ! -f /usr/local/apache2/conf/ssl/eccert.pem ] && [ ! -f /usr/local/apache2/conf/ssl/eckey.pem ]
    then
      openssl ecparam -name prime256v1 > /tmp/prime256v1.ecparam
      openssl req -x509 -newkey ec:/tmp/prime256v1.ecparam -nodes -sha256 -batch \
              -days 1825 -config /tmp/openssl.conf -extensions ext \
              -keyout /usr/local/apache2/conf/ssl/eckey.pem -out /usr/local/apache2/conf/ssl/eccert.pem \
              -subj "/C=AQ/O=Example Corp./CN=www.example.com" > /dev/null 2>&1
    fi
    rm -f /tmp/openssl.conf /tmp/prime256v1.ecparam
  fi

  if [ ! -f /usr/local/apache2/conf/ssl/chain.pem ]
  then
    echo "/usr/local/apache2/conf/ssl/chain.pem not found, copying from /usr/local/apache2/conf/ssl/cert.pem and /usr/local/apache2/conf/ssl/eccert.pem"
    cat /usr/local/apache2/conf/ssl/cert.pem /usr/local/apache2/conf/ssl/eccert.pem > /usr/local/apache2/conf/ssl/chain.pem
  fi

  echo "starting uwsgi in background"
  uwsgi --ini /etc/uwsgi/uwsgi.ini --die-on-term &

  shift 1
  echo "starting httpd"
  exec httpd-foreground
fi

exec "$@"
