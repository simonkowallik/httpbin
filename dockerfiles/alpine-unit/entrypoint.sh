#!/usr/bin/env sh
set -e

if [ ! -f /var/lib/unit/certs/bundle ]
then
  echo "/var/lib/unit/certs/bundle not found, generating self-signed bundle"
  echo -e "[req]\ndistinguished_name=dn\n[dn]\n[ext]\n"\
           "basicConstraints=critical,CA:FALSE\n"\
           "keyUsage=critical,digitalSignature,keyEncipherment\n"\
           "subjectAltName=DNS:example.com,DNS:www.example.com\n"\
           "extendedKeyUsage=critical,serverAuth,clientAuth\n" > /tmp/openssl.conf

  openssl req -x509 -newkey rsa:2048 -nodes -sha256 -batch \
          -days 1825 -config /tmp/openssl.conf -extensions ext \
          -keyout /tmp/key.pem -out /tmp/cert.pem \
          -subj "/C=AQ/O=Example Corp./CN=www.example.com" > /dev/null 2>&1
  mkdir -p /var/lib/unit/certs
  cat /tmp/cert.pem /tmp/key.pem > /var/lib/unit/certs/bundle
  rm -f /tmp/openssl.conf /tmp/cert.pem /tmp/key.pem
fi

exec "$@"
