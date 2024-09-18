#!/bin/bash

usuario=$(whoami)
timestamp=$(date +%Y%m%d%H%M%S)

# Função que habilita o alto contraste no terminal
# Inicialmente esta função testa se a tela já está no contraste máximo, ou seja, se as cores
# branco e preto já estão sendo utilizadas em background e foreground. Se não estiver, fornece
# as opções para o usuário.
altoContraste() {
	if [[ (($R1 != "rgb:ffff/ffff/ffff" && $R1 != "rgb:FFFF/FFFF/FFFF") || $R2 != "rgb:0000/0000/0000") && (($R2 != "rgb:ffff/ffff/ffff" && $R2 != "rgb:FFFF/FFFF/FFFF") || $R1 != "rgb:0000/0000/0000") ]]; then
	    while true; do
	        echo "Habilitar alto contraste?"
	        echo "1: Sim"
	        echo "2: Não"
	        echo "Obs.: ao finalizar o script, suas cores padrão serão restauradas."
	        echo "----------"
	        read -p "Digite uma das opções acima: " OPCAO
	        echo "----------"   
	        case $OPCAO in
	            1|2) break ;; 
	            *) echo -e "Opção inválida, digite novamente! " && sleep 1;;
	        esac
	    done

	    # Se optar pelo alto contraste, o texto ficará preto e o fundo branco.
	    if [ $OPCAO = 1 ]; then
	        echo -ne '\e]11;#FFFFFF\e\\'
	        echo -ne '\e]10;#000000\e\\'
	    fi  
	fi
}

pegaCoresTerminal() {
    oldstty=$(stty -g)
    Ps=${1:-11}
    stty raw -echo min 0 time 0
    printf "\033]$Ps;?\033\\"
    sleep 0.2
    read -r answer
    result1=${answer#*;}
    stty $oldstty
    sleep 0.2
    oldstty=$(stty -g)
    Ps=${1:-10}
    stty raw -echo min 0 time 0
    printf "\033]$Ps;?\033\\"
    sleep 0.2
    read -r answer
    result2=${answer#*;}
    stty $oldstty
    R1=$(echo $result1 | sed 's/[^rgb:0-9a-f/]\+$//')
    R2=$(echo $result2 | sed 's/[^rgb:0-9a-f/]\+$//')
}

restauraCores() {
    echo -ne "\033]11;$R1\007"
    echo -ne "\033]10;$R2\007"
}

encerraPrograma() {
	restauraCores
 	echo ""
	exit $1
}

abortaScript() {
	encerraPrograma
}

pegaCoresTerminal
trap encerraPrograma SIGINT

altoContraste

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
        2 ) encerraPrograma 0;;
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

encerraPrograma
