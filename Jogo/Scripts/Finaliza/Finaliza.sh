#!/bin/bash

usuario=$(whoami)
timestamp=$(date +%Y%m%d%H%M%S)

echo -e "--------------------\nScript de finalização\n--------------------\n"
echo "Este script:"
echo " * gerará as estatísticas da competição;"
echo " * fará um backup do banco de dados; e"
echo -e " * poderá redefinir as regras de acesso da pasta TreasureHunt no servidor web\n"
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

echo
bash EstatisticasBD.sh $usuario $timestamp
echo
read -n 1 -s -r -p "Pressione qualquer tecla para continuar..."
echo
echo
bash BackupBD.sh $usuario $timestamp
echo
read -n 1 -s -r -p "Pressione qualquer tecla para continuar..."
echo
echo

opcao=""
while true; do
    echo "Deseja bloquear o acesso a pasta do Treasure Hunt no servidor web e desligar o ngrok?"
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
    # Adiciona regra no arquivo .htaccess para impedir o acesso a página
    echo -e "Order Deny,Allow\nDeny from all\nAllow from 127.0.0.1" | sudo tee /var/www/html/TreasureHunt/.htaccess > /dev/null
    echo
    # Desliga ngrok
    killall ngrok 2> /dev/null
fi

opcao=""
while true; do
    echo "Deseja fazer o relatório do questionário?"
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
    read -e -p "Digite o caminho do arquivo do questionário (arquivo .dat): " caminho
    arquivo="/home/$usuario/th-relatorios/$timestamp/relatorio_questionario.md"
    Rscript EstatisticasQuestionario.r $caminho 1> $arquivo
    echo -e "\nRelatório do questionário salvo em: "
    echo "$arquivo"
fi
