FROM ubuntu:latest

LABEL maintainer="Eduard Saller <github@saller.io>"
ENV TZ=Europe/Berlin

RUN apt-get update && apt-get install -y  \
    git \
    make \
    sudo \
    curl \
    locales \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root/

#RUN git clone https://github.com/ESaller/dotfiles
ADD . ./dotfiles/
RUN locale-gen en_US.UTF-8

RUN cd ./dotfiles && make all

CMD ["/bin/zsh"]