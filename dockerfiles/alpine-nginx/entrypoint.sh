#!/usr/bin/env sh
set -e

if [ ! -f /etc/nginx/ssl/dhparam.pem ]
then
  echo "/etc/nginx/ssl/dhparam.pem not found, generating..."
  openssl dhparam -dsaparam -out /etc/nginx/ssl/dhparam.pem 2048 > /dev/null 2>&1
fi

if [ ! -f /etc/nginx/ssl/cert.pem ] && [ ! -f /etc/nginx/ssl/key.pem ]
then
  echo "/etc/nginx/ssl/cert.pem+key.pem not found, generating self-signed cert+key"
  echo -e "[req]\ndistinguished_name=dn\n[dn]\n[ext]\n"\
           "basicConstraints=critical,CA:FALSE\n"\
           "keyUsage=critical,digitalSignature,keyEncipherment\n"\
           "subjectAltName=DNS:example.com,DNS:www.example.com\n"\
           "extendedKeyUsage=critical,serverAuth,clientAuth\n" > /tmp/openssl.conf

  openssl req -x509 -newkey rsa:2048 -nodes -sha256 -batch \
          -days 1825 -config /tmp/openssl.conf -extensions ext \
          -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem \
          -subj "/C=AQ/O=Example Corp./CN=www.example.com" > /dev/null 2>&1
  rm /tmp/openssl.conf
fi

if [ ! -f /etc/nginx/ssl/chain.pem ]
then
  echo "/etc/nginx/ssl/chain.pem not found, linking to cert.pem"
  ln -s /etc/nginx/ssl/cert.pem /etc/nginx/ssl/chain.pem
fi

echo "starting uwsgi in background"
uwsgi --ini /etc/uwsgi/uwsgi.ini --die-on-term &

if [ "$1" == "run_nginx" ]
then
  exec nginx -g 'daemon off;'
else
  exec $@
fi
