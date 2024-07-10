#!/bin/bash
user=$(whoami)
timestamp=$(date +%Y%m%d%H%M%S)

# Verifica se o serviço do apache é chamado de apache2, se não for, tenta chamar de httpd
apache_service="apache2"
if [ -z "$(systemctl list-unit-files | grep $apache_service)" ]; then
    apache_service="httpd"
fi
mysql_service="mysql"

bash ./EstatisticasBD.sh
echo
bash ./BackupBD.sh $user $timestamp

echo "Deseja parar os serviços do apache e mysql?"
answer=""
while true; do
    read -p "s/n: " answer
    case $answer in
        [SsNn]* ) break;;
        * ) echo "Por favor, responda com s ou n.";;
    esac
done

if [[ $answer =~ [Ss] ]]; then
    sudo systemctl stop $apache_service
    sudo systemctl stop $mysql_service
fi
