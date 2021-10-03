FROM ubuntu:bionic

RUN chsh -s /bin/bash
SHELL ["/bin/bash", "-ic", "-l"]
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt-cache search libreadline
RUN apt-get install -y libssl1.0-dev gnupg2 sudo curl gcc make libreadline7 libreadline-dev git libc6-dev libevent-dev libpcre2-dev libpcre3-dev libxml2 libxml2-dev libpng-dev libyaml-dev zlib1g-dev

# RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
# USER docker

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
RUN echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
RUN source ~/.bashrc
RUN which asdf
RUN asdf plugin-add crystal https://github.com/asdf-community/asdf-crystal.git
RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

RUN asdf install crystal 1.1.1
RUN asdf install nodejs 16.6.2


RUN asdf global crystal 1.1.1
RUN asdf global nodejs 16.6.2

RUN asdf current

RUN npm install -g yarn

WORKDIR /srv/app

ADD . .

RUN yarn install
RUN shards install

RUN yarn prod
RUN crystal build --release src/start_server.cr

ENV DATABASE_URL=postgres://postgres:postgres@138.68.36.188:5432/flashcards_production
ENV LUCKY_ENV=production
ENV HOST=0.0.0.0
ENV PORT=80
ENV SECRET_KEY_BASE=4B1YCDBBpkTVrIo+FUeSTPC+L7lG+hJGCYDaCT0qrFI=
ENV APP_DOMAIN=http://flaschards.skinnyjames.net
ENV SEND_GRID_KEY=unused 

RUN crystal run tasks.cr -- db.migrate


CMD ["/srv/app/start_server"]
