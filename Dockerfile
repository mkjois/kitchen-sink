FROM ubuntu:15.04
MAINTAINER Manny Jois <m.k.jois@gmail.com>

WORKDIR /opt/kitchen-sink
COPY . .

RUN \
    cp scripts/docker/init /usr/sbin/my_init && \
    scripts/node/setup_0.12 && \
    apt-get install -y nodejs && \
    npm install --production && \
    scripts/docker/imclean

EXPOSE 5056
CMD ["/usr/sbin/my_init", "node", "lib/server.js"]
