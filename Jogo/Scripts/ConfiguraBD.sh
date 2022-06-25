#variáveis

QUANT_JOGADORES=$1 
QUANT_DESAFIOS=$2
ADICIONAR_EASTER_EGG=$3


if [ $ADICIONAR_EASTER_EGG = "0" ]; then 
	QUANT_DESAFIOS=`expr $QUANT_DESAFIOS + 1`
fi 

# Cria o Banco de Dados TreasureHunt, caso não exista
echo "CREATE SCHEMA IF NOT EXISTS TreasureHunt;"
#sleep 3

# Remove as tabelas Usuario e Resposta do Schema TreasureHunt
echo "DROP TABLE IF EXISTS TreasureHunt.Submissao;"
echo "DROP TABLE IF EXISTS TreasureHunt.Resposta;"
echo "DROP TABLE IF EXISTS TreasureHunt.Usuario;"

# Cria a tabela de Usuários, caso não exista
# Nova tabela: não precisa armazenar o salt (bcrypt armazena no próprio hash)
echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Usuario (id INT(11) NOT NULL AUTO_INCREMENT, pass VARCHAR(64) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=big5;"

# Antiga tabela: precisava armazenar o salt separado (sha256)
# echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Usuario (id INT(11) NOT NULL AUTO_INCREMENT, saltpass VARCHAR(10) NOT NULL, pass VARCHAR(64) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=big5;"


# Cria a tabela que conterá as respostas
echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Resposta (idUsuario INT(11) NOT NULL, idProblema INT(11) NOT NULL, resposta VARCHAR(64) NOT NULL, tentativas INT(11) NOT NULL, acertou BOOL NOT NULL, hora TIMESTAMP DEFAULT 0, PRIMARY KEY (idUsuario, idProblema), FOREIGN KEY (idUsuario) REFERENCES TreasureHunt.Usuario(id)) ENGINE=InnoDB CHARSET=big5;"

# Cria a tabela que conterá as submissões
# Para verificar se há cópia de flag
echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Submissao (idUsuario INT(11) NOT NULL, idProblema INT(11) NOT NULL, respostaInformada VARCHAR(64) NOT NULL, ip VARCHAR(16) NOT NULL, hora TIMESTAMP, PRIMARY KEY (idUsuario, idProblema, hora)) ENGINE=InnoDB CHARSET=big5;"


# Cria registros de usuários com ID e senha padrão '$i$i$i' (3x o ID)
for i in $(seq $QUANT_JOGADORES)
do
	SENHA=`htpasswd -bnBC 10 '' "$i$i$i???" | tr -d ':\n'`
	echo "INSERT INTO TreasureHunt.Usuario (pass) VALUES ('$SENHA');"
done

# Insere as respostas na tabela Resposta
for i in $(seq $QUANT_JOGADORES)
do
	for j in $(seq $QUANT_DESAFIOS)
	do
		RESPOSTA=$(head -$i "../Respostas/Respostas_Desafio_$j" | tail -1)
		HASH_RESPOSTA=`htpasswd -bnBC 10 '' $RESPOSTA | tr -d ':\n'`
		echo "INSERT INTO TreasureHunt.Resposta (idUsuario, idProblema, resposta, tentativas, acertou) VALUES ($i, $j, '$HASH_RESPOSTA', 0, 0);"
	done
done

echo "exit"
