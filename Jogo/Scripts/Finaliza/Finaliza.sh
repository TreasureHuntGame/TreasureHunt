#!/bin/bash

usuario=$(whoami)
timestamp=$(date +%Y%m%d%H%M%S)

echo -e "--------------------\nScript de finalização\n--------------------\n"
echo "Este script:"
echo " * gerará as estatísticas da competição;"
echo " * fará um backup do banco de dados; e"
echo -e " * parará os serviços apache e mysql\n"
echo "Você tem certeza que deseja iniciar esta ação?"
echo "Obs.: Certifique-se de ter removido eventuais dados inválidos, tais como submissões realizadas após o tempo"
echo "estipulado para a atividade ou de usuários não participantes, tais como o(s) organizador(es)."
echo

opcao=""
while true; do
    echo "Sua escolha"
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

# Verifica se o serviço do apache é chamado de apache2, se não for, tenta chamar de httpd
apache_servico="apache2"
if [ -z "$(systemctl list-unit-files | grep $apache_servico)" ]; then
    apache_servico="httpd"
fi
mysql_servico="mysql"

echo
bash EstatisticasBD.sh
echo
bash BackupBD.sh $usuario $timestamp
echo

opcao=""
while true; do
    echo "Deseja parar os serviços apache e mysql?"
    echo "1: Sim"
    echo "2: Não"
    echo "----------"
    read -p "Digite uma das opções acima: " opcao
    echo "----------"   
    case $opcao in
        1|2 ) break;;
        *) echo -e "Opção inválida, digite novamente! " && sleep 1;;
    esac
done

if [[ $opcao -eq 1 ]]; then
    sudo systemctl stop $apache_servico
    sudo systemctl stop $mysql_servico
fi
