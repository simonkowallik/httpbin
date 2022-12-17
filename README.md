# httpbin : sk-features


## httpbin(1): HTTP Request & Response Service

This httpbin fork is updated and tailored to my personal needs.
As [postmanlabs / httpbin](https://github.com/postmanlabs/httpbin) is stale and did not see an update in several years I felt the need to maintain my own version.

## Supported docker tags

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


## Usage

Simple example:

```sh
    docker run -p 80:80 -p 443:443 simonkowallik/httpbin:nginx

    docker run -p 80:80 -p 443:443 simonkowallik/httpbin:unit

    docker run -p 80:80 simonkowallik/httpbin
```

## Differences to upstream postmanlabs/httpbin

At the time of writing this are the differences:

- ~~[adds server network info app.route and to /anything #1](https://github.com/simonkowallik/httpbin/pull/1)~~ removed, replaced by [add environment /tags feature](https://github.com/simonkowallik/httpbin/pull/5)
- [add environment /tags feature](https://github.com/simonkowallik/httpbin/pull/5)
- [adds X-Powered-By: httpbin/\<version> Header - #431 #2](https://github.com/simonkowallik/httpbin/pull/2)
- [adds /customresponse/\<base64> endpoint to generate custom responses #3](https://github.com/simonkowallik/httpbin/pull/3)
- [adds alpine:3.10 Dockerfile #4](https://github.com/simonkowallik/httpbin/pull/4/files)
- [Replace brotlipy with Brotli](https://github.com/simonkowallik/httpbin/pull/6)
- [adds dockerfile with nginx+uwsgi + TLS](https://github.com/simonkowallik/httpbin/pull/7)
