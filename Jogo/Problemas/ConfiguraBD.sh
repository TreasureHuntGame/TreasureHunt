# Cria o Banco de Dados TreasureHunt, caso não exista
echo "CREATE SCHEMA IF NOT EXISTS TreasureHunt;"
#sleep 3

# Remove as tabelas Usuario e Resposta do Schema TreasureHunt
echo "DROP TABLE IF EXISTS TreasureHunt.Submissao;"
echo "DROP TABLE IF EXISTS TreasureHunt.Resposta;"
echo "DROP TABLE IF EXISTS TreasureHunt.Usuario;"

# Cria a tabela de Usuários, caso não exista
echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Usuario (id INT(11) NOT NULL AUTO_INCREMENT, saltpass VARCHAR(10) NOT NULL, pass VARCHAR(64) NOT NULL, PRIMARY KEY (id)) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=big5;"

# Cria a tabela que conterá as respostas
echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Resposta (idUsuario INT(11) NOT NULL, idProblema INT(11) NOT NULL, resposta VARCHAR(64) NOT NULL, tentativas INT(11) NOT NULL, acertou BOOL NOT NULL, hora TIMESTAMP DEFAULT 0, PRIMARY KEY (idUsuario, idProblema), FOREIGN KEY (idUsuario) REFERENCES TreasureHunt.Usuario(id)) ENGINE=InnoDB CHARSET=big5;"

# Cria a tabela que conterá as submissões
# Para verificar se há cópia de flag
# echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Submissao (idUsuario INT(11) NOT NULL, idProblema INT(11) NOT NULL, respostaInformada VARCHAR(64) NOT NULL, hora TIMESTAMP, PRIMARY KEY (idUsuario, idProblema, hora)) ENGINE=InnoDB CHARSET=big5;"
echo "CREATE TABLE IF NOT EXISTS TreasureHunt.Submissao (idUsuario INT(11) NOT NULL, idProblema INT(11) NOT NULL, respostaInformada VARCHAR(64) NOT NULL, ip VARCHAR(16) NOT NULL, hora TIMESTAMP, PRIMARY KEY (idUsuario, idProblema, hora)) ENGINE=InnoDB CHARSET=big5;"

# Cria registros de usuários com ID e senha padrão '$i$i$i' (3x o ID)
for i in $(seq $1)
do
	SALT=$(cat /dev/urandom | tr -cd 'a-z' | head -c 9)
	SENHA=$(echo -n $i-$i-$i$SALT | sha256sum | head -c-4)
	echo "INSERT INTO TreasureHunt.Usuario (saltpass, pass) VALUES ('$SALT', '$SENHA');"
done

# Insere as respostas na tabela Resposta
for i in $(seq $1)
do
	for j in $(seq $2)
	do
		RESPOSTA=$(head -$i "../Respostas/Respostas_Desafio_$j" | tail -1)
		HASH_RESPOSTA=$(echo -n $RESPOSTA | sha256sum | head -c-4)
		echo "INSERT INTO TreasureHunt.Resposta  (idUsuario, idProblema, resposta, tentativas, acertou) VALUES ($i, $j, '$HASH_RESPOSTA', 0, 0);"
	done
done

echo "exit"