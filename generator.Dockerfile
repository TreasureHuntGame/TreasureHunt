FROM ubuntu:18.04

# Dessa maneira permite o docker usar o cache
RUN apt-get update && apt-get install -y lshw \
                       coreutils \
                       bash \
                       bsdgames \
                       default-jre \
                       default-jdk \
                       openjdk-8-jdk \
                       openjdk-8-jre \
                       gawk \
                       grep \
                       curl \
                       apache2-utils \
                       bc \
                       binutils \
                       outguess \
                       python3 \
                       xxd \
                       zip \
                       mysql-client

COPY . /TreasureHunt

COPY ./TreasureHunt/. /var/www/html/TreasureHunt/

# Adiciona caminho para o programa caesar do bsdgames (Nota 9)
ENV PATH="/usr/games/:${PATH}"
ENV TH_DB_HOST="db"

WORKDIR /TreasureHunt
