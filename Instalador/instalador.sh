#!/bin/bash

#$1 = mensagem de alerta antes de finalizar o script
finalizar_script(){
	echo "$1"
	echo "$1" >> $arquivo_log
	echo "Script finalizado sem sucesso!"
	echo "Script finalizado sem sucesso!" >> $arquivo_log
	exit 1
}

#$1 = nome do pacote
instalar_pacote(){
	echo "Instalando pacote: $1"
	pacote_log="$diretorio_log/$1.log"
	> $pacote_log #cria arquivo vazio
	apt-get install -y $1 >>$pacote_log 2>>$pacote_log &
	pid=$!
	while kill -0 $pid 2>/dev/null; do
		echo -ne "Instalando.\r" && sleep 1
		echo -ne "Instalando..\r" && sleep 1
		echo -ne "Instalando...\r" && sleep 1
		echo -ne "\r\033[2K"
	done
	if [ $? -ne 0 ]; then
		echo -e "Pacote não foi instalado com sucesso!\n"
		echo -e "Pacote não foi instalado com sucesso!\n" >> $arquivo_log
	else
		echo -e "Pacote instalado com sucesso!\n"
		echo -e "Pacote instalado com sucesso!\n" >> $arquivo_log	
	fi
}

#Inicializa as variavéis de timestamp
ts=`date +%s`
tsh=`date`

#Inicializa os logs
diretorio_log="logs/thi_$ts"
arquivo_log="$diretorio_log/thi_relatorio.log"
mkdir -p $diretorio_log
> $arquivo_log

#Informações gerais sobre o funcionamento do script e do github
echo "Este script está armazenando os resultados das operações realizadas em um relatório (log)."
echo "Se você encontrar algum problema, por favor consulte o arquivo: $arquivo_log"
echo "Se você precisar de ajuda, encontrou um bug, ou quer sugerir uma funcionalidade, crie um 'problema' no github deste projeto!"
echo -e "\nScript inicializado!\n"

#Se não especificou o arquivo de requisitos, padrao = "requisitos.txt"
arquivo_req=${1:-"requisitos.txt"}

#Se não for root/sudo
if [ "$EUID" -ne 0 ]; then
	finalizar_script "Permissões de super usuário necessárias para instalar os pacotes!"
fi

#Se não houver o apt-get instalado
if ! hash apt-get 2>/dev/null; then
	finalizar_script "apt-get não foi encontrado!"
fi

#Se o arquivo de requisitos não existir
if [ ! -f $arquivo_req ]; then
	finalizar_script "Arquivo de requisitos ($arquivo_req) não foi encontrado!"
else
	echo -e "Script inicializado em: $tsh\n" >> $arquivo_log
	info=$(uname -a)
	echo -e "Linux: $info\n" >> $arquivo_log
	info=$(lshw -sanitize) #remove informações sensiveis 
	echo -e "Hardware:\n$info" >> $arquivo_log
fi

while IFS="" read -r pacote; do
	if [ $pacote == "mysql-server" ] && [ ! hash mysql 2>/dev/null]; then # se o mysql não existir na maquina
		debconf-set-selections <<< 'mysql-server mysql-server/root_password password treasure_hunt' #coloca senha 'padrão', avisar usuário no instalador, e também na 
		debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password treasure_hunt' # documentação sobre isso, e como mudar.
		echo "Senha utilizada na instalação do MySQL: treasure_hunt"
		echo -e "\nPor favor mude a senha do mysql, para isso execute o seguinte comando (super usuário):"
		echo -e "mysqladmin -u root password SENHA_NOVA\n"
	fi
	instalar_pacote $pacote
done < "$arquivo_req"
