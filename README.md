# httpbin(1): HTTP Request & Response Service

[![httpbin Tests](https://github.com/simonkowallik/httpbin/actions/workflows/httpbin-ci.yaml/badge.svg)](https://github.com/simonkowallik/httpbin/actions/workflows/httpbin-ci.yaml)
[![Container Build](https://github.com/simonkowallik/httpbin/actions/workflows/container-build.yaml/badge.svg)](https://github.com/simonkowallik/httpbin/actions/workflows/container-build.yaml)

This httpbin fork is updated and tailored to my personal needs.
As [postmanlabs / httpbin](https://github.com/postmanlabs/httpbin) is stale and did not see an update in several years I felt the need to maintain my own version.

## Supported docker tags

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simonkowallik/httpbin/latest?label=latest)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simonkowallik/httpbin/alpine?label=alpine)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simonkowallik/httpbin/nginx?label=nginx)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simonkowallik/httpbin/httpd?label=httpd)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simonkowallik/httpbin/httpd-alpine?label=httpd-alpine)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simonkowallik/httpbin/unit?label=unit)

- **`:latest`** / **`:alpine`** : Plain httpbin with gunicorn on Debian / Alpine Linux.

- **`:nginx`** : Uses [nginx](https://github.com/nginx/nginx) and [uwsgi](https://github.com/unbit/uwsgi) with `nginx:alpine` as the base image.

    > Supports HTTPS and HTTP2. TLS Certificates & keys are automatically generated but can be overwritten / mapped using docker:
    >
    > - `/etc/nginx/ssl/dhparam.pem`
    > - `/etc/nginx/ssl/eccert.pem` (ecdsa)
    > - `/etc/nginx/ssl/eckey.pem` (ecdsa)
    > - `/etc/nginx/ssl/cert.pem` (rsa)
    > - `/etc/nginx/ssl/key.pem` (rsa)
    > - `/etc/nginx/ssl/chain.pem`
    > - `/etc/nginx/nginx.conf`
    > - `/etc/uwsgi/uwsgi.ini`

- **`:unit`** : Uses [nginx unit](https://github.com/nginx/unit) with base image `alpine`.

    > Supports HTTPS and HTTP2. TLS Certificates & keys are automatically generated but can be overwritten / mapped using docker:
    >
    > - `/var/lib/unit/certs/bundle` (bundle content created by: `cat cert.pem cachain.pem key.pem > bundle`)
    > - `/var/lib/unit/conf.json`

- **`:httpd`** : Uses [httpd](https://github.com/docker-library/httpd) and [uwsgi](https://github.com/unbit/uwsgi) with `httpd:latest` as the base image.

    > Supports HTTPS. TLS Certificates & keys are automatically generated but can be overwritten / mapped using docker:
    >
    > - `/usr/local/apache2/conf/ssl/dhparam.pem`
    > - `/usr/local/apache2/conf/ssl/eccert.pem` (ecdsa)
    > - `/usr/local/apache2/conf/ssl/eckey.pem` (ecdsa)
    > - `/usr/local/apache2/conf/ssl/cert.pem` (rsa)
    > - `/usr/local/apache2/conf/ssl/key.pem` (rsa)
    > - `/usr/local/apache2/conf/ssl/chain.pem`
    > - `/usr/local/apache2/conf/httpd.conf`
    > - `/usr/local/apache2/conf/extra/vhosts/*.conf`
    > - `/etc/uwsgi/uwsgi.ini`

- **`:httpd-alpine`** : Uses [httpd](https://github.com/docker-library/httpd) and [uwsgi](https://github.com/unbit/uwsgi) with `httpd:alpine` as the base image.

    > Supports HTTPS. TLS Certificates & keys are automatically generated but can be overwritten / mapped using docker:
    >
    > - `/usr/local/apache2/conf/ssl/dhparam.pem`
    > - `/usr/local/apache2/conf/ssl/eccert.pem` (ecdsa)
    > - `/usr/local/apache2/conf/ssl/eckey.pem` (ecdsa)
    > - `/usr/local/apache2/conf/ssl/cert.pem` (rsa)
    > - `/usr/local/apache2/conf/ssl/key.pem` (rsa)
    > - `/usr/local/apache2/conf/ssl/chain.pem`
    > - `/usr/local/apache2/conf/httpd.conf`
    > - `/usr/local/apache2/conf/extra/vhosts/*.conf`
    > - `/etc/uwsgi/uwsgi.ini`

## Usage

Simple example:

```sh
    docker run -p 80:80 -p 443:443 simonkowallik/httpbin:nginx

    docker run -p 80:80 -p 443:443 simonkowallik/httpbin:httpd

    docker run -p 80:80 -p 443:443 simonkowallik/httpbin:httpd-alpine

    docker run -p 80:80 -p 443:443 simonkowallik/httpbin:unit

    docker run -p 80:80 simonkowallik/httpbin
```

## Advanced features

### Return custom HTTP header and value on every response

```shell
$ docker run -it --rm -p 80:80 -p 443:443 \
  -e XHTTPBIN_X_instance_id="instance-id-1" \
  ghcr.io/simonkowallik/httpbin:unit

```

```sheel
$ curl -vsk http://localhost/get
..
> GET /get HTTP/1.1
..
< HTTP/1.1 200 OK
..
< X-Powered-By: httpbin/0.9.2
< X-instance-id: instance-id-1
< Server: Unit/1.28.0
..
```

### Set custom tags on `/tags` endpoint

```shell
$ docker run -it --rm -p 80:80 -p 443:443 \
  -e HTTPBIN_Instance=1 \
  -e HTTPBIN_2ndTag="Some Value" \
  ghcr.io/simonkowallik/httpbin:nginx

```

```shell
$ curl -vsk http://localhost/tags

> GET /tags HTTP/1.1
> Host: localhost:11080
> User-Agent: curl/7.74.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Server: nginx/1.23.3
< Date: Sat, 17 Dec 2022 14:45:48 GMT
< Content-Type: application/json
< Content-Length: 48
< Connection: keep-alive
< X-Powered-By: httpbin/0.9.2
< Access-Control-Allow-Origin: *
< Access-Control-Allow-Credentials: true
<
{
  "2ndTag": "Some Value",
  "Instance": "1"
}
```

## Contributors

Thanks to:

- [@v-slenter](https://github.com/v-slenter) for [#9](https://github.com/simonkowallik/httpbin/pull/9)
