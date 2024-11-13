#!/bin/bash

echo -e "--------------------\nScript de backup do banco de dados\n--------------------\n"

# Verifica se o serviço MySQL está rodando
if [ "$(systemctl is-active mysql)" != "active" ]; then
    echo "O serviço MySQL não está rodando." >&2
    exit 1
fi

usuario=$1
timestamp=$2
arquivo=/home/$usuario/th-backups/$timestamp/backup.sql

echo "Dump do banco de dados da competição TreasureHunt salvo em:"
echo -e "$arquivo\n"
mkdir -p /home/$usuario/th-backups/$timestamp
mysqldump -u root TreasureHunt > $arquivo

opcao=""
while true; do
    echo "Deseja fazer backup direto no banco de dados?"
    echo "(Cria um novo banco de dados TreasureHunt_$timestamp e importa o backup nele)"
    echo "1: Sim"
    echo "2: Não"
    echo "----------"
    read -p "Digite uma das opções acima: " opcao
    echo "----------"   
    case $opcao in
        1 ) break;;
        2 ) exit 0;;
        *) echo -e "Opção inválida, digite novamente! " && sleep 1;;
    esac
done

# Verifica se o serviço mysql está rodando
if [ "$(systemctl is-active mysql)" != "active" ]; then
    echo "O serviço MySQL não está rodando."
    exit 1
fi

echo "Criando banco de dados de backup TreasureHunt_$timestamp"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS TreasureHunt_$timestamp;"
cat $arquivo | mysql -u root TreasureHunt_$timestamp

opcao=""
while true; do
    echo -e "\nDeseja limpar o banco de dados atual (TreasureHunt)?"
    echo "1: Sim"
    echo "2: Não"
    echo "----------"
    read -p "Digite uma das opções acima: " opcao
    echo "----------"   
    case $opcao in
        1 ) echo "Limpando banco de dados atual"; mysql -u root TreasureHunt < sql_queries/limpar.sql; break;;
        2 ) exit 0;;
        *) echo -e "Opção inválida, digite novamente! " && sleep 1;;
    esac
done

sleep 1
