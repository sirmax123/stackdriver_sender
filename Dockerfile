FROM ubuntu:16.04

RUN  \
  apt-get update && \
  apt-get -y install \
  python-pip \
  mc \
  git \
  screen \
  docker.io \
  inotify-tools \
  vim


RUN \
  pip install --upgrade pip && \
  pip install  google_cloud


COPY  main.sh /root/
COPY send_logs.py /root/

CMD ["/root/main.sh"]


