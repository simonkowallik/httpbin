# my custom httpbin(1): HTTP Request & Response Service

[latest/alpine: ![](https://images.microbadger.com/badges/image/simonkowallik/httpbin:alpine.svg)](https://microbadger.com/images/simonkowallik/httpbin:alpine)
[ubuntu: ![](https://images.microbadger.com/badges/image/simonkowallik/httpbin.svg)](https://microbadger.com/images/simonkowallik/httpbin)

This is my custom version of httpbin tailored to my personal needs.

I cannot guarantee it will keep track of all commits to [postmanlabs / httpbin](https://github.com/postmanlabs/httpbin) but I plan to submit pull requests for all changes to upstream.

# Differences
At the time of writing this are the differences:

- [adds server network info app.route and to /anything #1](https://github.com/simonkowallik/httpbin/pull/1)
- [adds adds X-Powered-By: httpbin/<version> Header - #431 #2](https://github.com/simonkowallik/httpbin/pull/2)
- [adds /customresponse/<base64> endpoint to generate custom responses #3](https://github.com/simonkowallik/httpbin/pull/3)
- [adds alpine:3.9 Dockerfile #4](https://github.com/simonkowallik/httpbin/pull/4/files)

# Docker Tags
`latest` and `alpine` both use alpine while `ubuntu` usues the original `ubuntu:18.04` base image.

# Run it locally

    docker run -p 80:80 simonkowallik/httpbin
