FROM debian:8
MAINTAINER Adrien Raffin <raffinadrien@gmail.com>

RUN \
  apt-get update && \
  apt-get install -y git \
    nodejs \
    npm && \
  useradd cyberchef -s /bin/bash && \
  npm install -g grunt-cli && \
  npm install -g http-server && \
  ln -s /usr/bin/nodejs /usr/bin/node

RUN \
  cd /srv && \
  git clone https://github.com/gchq/CyberChef.git && \
  cd CyberChef && \
  npm install && \
  chown cyberchef:cyberchef /srv/CyberChef -R && \
  grunt prod

WORKDIR /srv/CyberChef/build/prod
USER cyberchef

# Using grunt dev allows to run it as background task
ENTRYPOINT ["http-server", "-p", "8000"]
