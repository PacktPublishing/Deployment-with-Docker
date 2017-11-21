FROM ubuntu:latest

RUN apt-get update -q && \
    apt-get install -qy iputils-ping

CMD ["ping", "google.com"]
