FROM python:3.11-slim-bullseye

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ADD . /httpbin
WORKDIR /httpbin

RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir /httpbin

EXPOSE 80

CMD ["gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
