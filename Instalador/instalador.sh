#!/bin/bash

# gerenciador de pacotes que tentamos usar pra instalar os pacotes
pkg_managers=(dnf yum packman apt-get apt)

# array que mantém controle dos pacotes que já foram instalados por algum dos gerenciadores   
installed_pkgs=() 

#$1 = mensagem de alerta antes de finalizar o script
finalizar_script(){
	echo "$1"
	echo "$1" >> $arquivo_log
	echo "Script finalizado sem sucesso!"
	echo "Script finalizado sem sucesso!" >> $arquivo_log
	exit 1
}

# $1- nome do pacote 
instalar_pacote() {
	# para cada gerenciador de pacotes:  
	for gerenciador in "${pkg_managers[@]}"; do 
		# verifica se o pacote que queremos instalar já foi instalado nesse script 
		# por outro package manager. Se sim, sai da função.   
		for item in "${installed_pkgs[@]}"; do 
			if [ $item = $1 ]; then 
				return 1
			fi 
		done 
		# verificar se o gerenciador de pacotes pode ser executado
		if [ -x "$(command -v $gerenciador)" ]; then
			echo "Instalando pacote com $gerenciador: $1"
			pacote_log="$diretorio_log/$1.log"
			# verificando se é o packman (o único diferente nessa lista)
			if [ $gerenciador == 'packman' ]; then 
				packman -S --noconfirm $1 >>$pacote_log 2>>$pacote_log &
			else # do contrário usar sintaxe padrão
				$gerenciador install -y $1 >>$pacote_log 2>> $pacote_log & 
			fi 
			pid=$!
			while kill -0 $pid 2>/dev/null; do #exibir a "animação" do instalando... 
				echo -ne "Instalando.\r" && sleep 1
				echo -ne "Instalando..\r" && sleep 1
				echo -ne "Instalando...\r" && sleep 1
				echo -ne "\r\033[2K"
			done
			if [ $? -ne 0 ]; then # se o status de saída indica sucesso: 
				echo -e "Pacote $1 não foi instalado com sucesso! Verifique os logs para mais detalhes.\n"
				echo -e "Pacote $1 não foi instalado com sucesso ($gerenciador)!\n " >> $arquivo_log
			else # caso contrário
				installed_pkgs+=("$1")
				echo -e "Pacote $1 instalado com sucesso!\n"
				echo -e "Pacote $1 instalado com sucesso ($gerenciador)!\n" >> $arquivo_log	
			fi
		else # caso gerenciador de pacotes não consiga ser executado
			if [ $gerenciador = "${pkg_managers[-1]}" ]; then 
				finalizar_script "Nenhum gerenciador de arquivos da lista foi encontrado"
			fi 
		fi 
	done
}

#Inicializa as variavéis de timestamp
ts=`date +%d-%m-%y_%H:%M:%S`
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
# algum dos gerenciadores acima
installed_pkgs=() 

#$1 = mensagem de alerta antes de finalizar o script
finalizar_script(){
	echo "$1"
	echo "$1" >> $arquivo_log
	echo "Script finalizado sem sucesso!"
	echo "Script finalizado sem sucesso!" >> $arquivo_log
	exit 1
}

# $1- nome do pacote 
instalar_pacote() {
	# para cada gerenciador de pacotes:  
	for gerenciador in "${pkg_managers[@]}"; do 
		# verifica se o pacote que queremos instalar já foi instalado nesse script 
		# por outro package manager
		# se estiver sai da função  
		for item in "${installed_pkgs[@]}"; do 
			if [ $item = $1 ]; then 
				# echo -e "$item já instalado. \n" >> $arquivo_log
				return 1
			fi 
		done 
		# verificar se o gerenciador de pacotes pode ser executado
		if [ -x "$(command -v $gerenciador)" ]; then
			echo "Instalando pacote com $gerenciador: $1"
			pacote_log="$diretorio_log/$1.log"
			# verificando se é o packman, do contrário usar sintaxe padrão
			if [ $gerenciador == 'packman' ]; then 
				packman -S --noconfirm $1 >>$pacote_log 2>>$pacote_log &
			else 
				$gerenciador install -y $1 >>$pacote_log 2>> $pacote_log & 
			fi 
			pid=$!
			while kill -0 $pid 2>/dev/null; do
				echo -ne "Instalando.\r" && sleep 1
				echo -ne "Instalando..\r" && sleep 1
				echo -ne "Instalando...\r" && sleep 1
				echo -ne "\r\033[2K"
			done
			if [ $? -ne 0 ]; then
				echo -e "Pacote $1 não foi instalado com sucesso! Verifique os logs para mais detalhes.\n"
				echo -e "Pacote $1 não foi instalado com sucesso ($gerenciador)!\n " >> $arquivo_log
			else
				installed_pkgs+=("$1")
				echo -e "Pacote $1 instalado com sucesso!\n"
				echo -e "Pacote $1 instalado com sucesso ($gerenciador)!\n" >> $arquivo_log	
			fi
		else # caso gerenciador de pacotes não consiga ser executado
			if [ $gerenciador = "${pkg_managers[-1]}" ]; then 
				finalizar_script "Nenhum gerenciador de arquivos da lista foi encontrado"
			fi 
		fi 
	done
}

#Inicializa as variavéis de timestamp
ts=`date +%d-%m-%y_%H:%M:%S`
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