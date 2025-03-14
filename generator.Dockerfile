FROM ubuntu:18.04

RUN apt-get update && apt-get install -y
RUN apt-get install -y $(cat Instalador/docker_requisitos.txt)

COPY . /TreasureHunt

WORKDIR /TreasureHunt

RUN mkdir /var/www/html/TreasureHunt -p
RUN cp -r TreasureHunt/* /var/www/html/TreasureHunt

# Adiciona caminho para o programa caesar do bsdgames (Nota 9)
ENV PATH="/usr/games/:${PATH}"

WORKDIR /TreasureHunt

ENV TH_DB_HOST="db"
