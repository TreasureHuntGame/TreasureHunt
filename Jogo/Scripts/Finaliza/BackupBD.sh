#!/bin/bash
user=$1
timestamp=$2
today=$(date +%d/%m/%Y)
file=/home/$user/th-backup/$timestamp/backup.sql

echo "Dump do banco de dados da competição TreasureHunt do dia $today"
echo "no diretório $file"
mkdir -p /home/$user/th-backup/$timestamp
mysqldump -u root TreasureHunt > $file


echo -e "\nDeseja fazer backup direto no banco de dados?"
echo "(Cria um novo banco de dados TreasureHunt_$timestamp e importa o backup nele)"
while true; do
    read -p "s/n: " answer
    case $answer in
        [Ss]* ) break;;
        [Nn]* ) exit 0;;
        * ) echo "Por favor, responda com s ou n.";;
    esac
done

# Verifica se o serviço mysql está rodando
if [ "$(systemctl is-active mysql)" != "active" ]; then
    echo "O serviço mysql não está rodando"
    exit 1
fi

echo "Criando banco de dados de backup TreasureHunt_$timestamp"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS TreasureHunt_$timestamp;"
cat $file | mysql -u root TreasureHunt_$timestamp

echo -e "\nDeseja limpar o banco de dados atual (TreasureHunt)?"
while true; do
    read -p "s/n: " answer
    case $answer in
        [Ss]* ) echo "Limpando banco de dados atual"; mysql -u root TreasureHunt < sql_queries/clean.sql; break;;
        [Nn]* ) exit 0;;
        * ) echo "Por favor, responda com s ou n.";;
    esac
done
