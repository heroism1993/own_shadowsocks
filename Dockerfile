FROM ubuntu:14.04

WORKDIR /shadowsocks

COPY . /shadowsocks

RUN apt-get update && apt-get install -y \
    python-software-properties \
    software-properties-common \
 && add-apt-repository ppa:chris-lea/libsodium \
 && echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y libsodium-dev python-pip

RUN pip install shadowsocks

EXPOSE 25333
EXPOSE 11020
EXPOSE 16969

CMD ["python", "/usr/local/bin/ssserver", "-c", "/shadowsocks/server-dnsserver.json", "start"]