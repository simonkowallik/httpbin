# httpbin : sk-features
[![Travis Build Status](https://img.shields.io/travis/com/simonkowallik/httpbin/sk-features.svg?label=travis%20build)](https://travis-ci.com/simonkowallik/httpbin)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/simonkowallik/httpbin.svg?color=brightgreen)](https://hub.docker.com/r/simonkowallik/httpbin)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/simonkowallik/httpbin.svg)](https://hub.docker.com/r/simonkowallik/httpbin/builds)
[![](https://img.shields.io/microbadger/layers/simonkowallik/httpbin/alpine.svg?label=:latest%2F:alpine+layers)](https://microbadger.com/images/simonkowallik/httpbin:alpine)
[![](https://img.shields.io/microbadger/image-size/simonkowallik/httpbin/alpine.svg?label=:latest%2F:alpine+size)](https://microbadger.com/images/simonkowallik/httpbin:alpine)
[![](https://img.shields.io/microbadger/layers/simonkowallik/httpbin/ubuntu.svg?label=:ubuntu+layers)](https://microbadger.com/images/simonkowallik/httpbin:ubuntu)
[![](https://img.shields.io/microbadger/image-size/simonkowallik/httpbin/ubuntu.svg?label=:ubuntu+size)](https://microbadger.com/images/simonkowallik/httpbin:ubuntu)

## My custom httpbin(1): HTTP Request & Response Service
This is my custom version of httpbin tailored to my personal needs.
I cannot guarantee it will keep track of all commits to [postmanlabs / httpbin](https://github.com/postmanlabs/httpbin) but I plan to submit pull requests for all changes to upstream.

## Available docker tags
`:latest` and `:alpine` both use alpinelinux as the base image.

`:ubuntu` usues the original `ubuntu:18.04` base image.

## Run it locally
```sh
    docker run -p 80:80 simonkowallik/httpbin
```

## Differences to upstream postmanlabs/httpbin
At the time of writing this are the differences:

- [adds server network info app.route and to /anything #1](https://github.com/simonkowallik/httpbin/pull/1)
- [adds adds X-Powered-By: httpbin/<version> Header - #431 #2](https://github.com/simonkowallik/httpbin/pull/2)
- [adds /customresponse/<base64> endpoint to generate custom responses #3](https://github.com/simonkowallik/httpbin/pull/3)
- [adds alpine:3.9 Dockerfile #4](https://github.com/simonkowallik/httpbin/pull/4/files)