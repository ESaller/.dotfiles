FROM ubuntu:latest

LABEL maintainer="Eduard Saller <github@saller.io>"

RUN apt-get update && apt-get install -y  \
    git \
    make \
    sudo \
    curl \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

#RUN git clone https://github.com/ESaller/dotfiles
ADD . /dotfiles/

RUN cd /dotfiles && make all

CMD ["/bin/zsh"]