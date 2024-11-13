#!/bin/bash

formataValorFloat() {
    printf "%.2f" $1
}

usuario=$1
timestamp=$2

echo -e "--------------------\nScript de geração de estatísticas\n--------------------\n"

# Verifica se o serviço MySQL está rodando
if [ "$(systemctl is-active mysql)" != "active" ]; then
    echo "O serviço MySQL não está rodando." >&2
    exit 1
fi

consulta="SELECT COUNT(DISTINCT idProblema) FROM Resposta"
quantidadeQuestoes=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)

consulta="SELECT SUM(tentativas) FROM Resposta"
quantidadeSubmissoes=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)

consulta="SELECT SUM(acertou) FROM Resposta"
quantidadeSubmissoesCorretas=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)

consulta="SELECT COUNT(DISTINCT idUsuario) FROM Submissao WHERE respostaInformada = 'submissaoPadrao'"
quantidadeUsuarios=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)

mediaAcertos=$(echo "$quantidadeSubmissoesCorretas / $quantidadeUsuarios" | bc -l)

desempenho=$(echo "100 * ($quantidadeSubmissoesCorretas / ($quantidadeQuestoes * $quantidadeUsuarios))" | bc -l)
desempenhoSemEasteregg=$(echo "100 * ($quantidadeSubmissoesCorretas / (($quantidadeQuestoes - 1) * $quantidadeUsuarios))" | bc -l)
taxaSubmissoesCorretas=$(echo "100 * $quantidadeSubmissoesCorretas / $quantidadeSubmissoes" | bc -l)

mediaAcertos=$(formataValorFloat $mediaAcertos)
desempenho=$(formataValorFloat $desempenho)
desempenhoSemEasteregg=$(formataValorFloat $desempenhoSemEasteregg)
taxaSubmissoesCorretas=$(formataValorFloat $taxaSubmissoesCorretas)

arquivo="/home/$usuario/th-relatorios/$timestamp/relatorioBD.md"

mkdir -p /home/$usuario/th-relatorios/$timestamp
echo -e "# Desempenho da turma\n" > $arquivo
echo "Media de acertos: $mediaAcertos" >> $arquivo
echo "Desempenho da turma: $desempenhoSemEasteregg%" >> $arquivo
echo "Desempenho da turma com o easteregg: $desempenho%" >> $arquivo
echo "Quantidade total de submissoes: $quantidadeSubmissoes" >> $arquivo
echo "Quantidade total de submissoes corretas: $quantidadeSubmissoesCorretas" >> $arquivo
echo "Taxa de submissoes corretas: $taxaSubmissoesCorretas%" >> $arquivo

# -- Detector de respostas repetidas (possivelmente plagiadas) --
consulta="SELECT respostaInformada, COUNT(*) c FROM Submissao WHERE respostaInformada != 'submissaoPadrao' GROUP BY respostaInformada HAVING c > 1;"
respostasRepetidas=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
i=0
echo -e "\n" >> $arquivo
echo "# Análise de Comportamentos Suspeitos e Ataques Potenciais" >> $arquivo
if [ -n "$respostasRepetidas" ]; then
    echo "## Respostas repetidas:" >> $arquivo
else
    echo "Nenhuma resposta repetida." >> $arquivo
fi
for resposta in $respostasRepetidas; do
    if [ $i -eq 0 ]; then
        consulta="SELECT DISTINCT idUsuario FROM Submissao WHERE respostaInformada = '$resposta' ORDER BY hora"
        possiveisTrapaceiros=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
        echo "Resposta '$resposta':" >> $arquivo
        for possivelTrapaceiro in $possiveisTrapaceiros; do
            consulta="SELECT idProblema, hora FROM Submissao WHERE respostaInformada = '$resposta' AND idUsuario = $possivelTrapaceiro"
            linha=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
            echo "Usuário $possivelTrapaceiro enviou a resposta $resposta para o problema $(echo $linha | cut -d' ' -f1) às $(echo $linha | cut -d' ' -f2,3)" >> $arquivo
        done
        i=1
    else
        i=0
        echo >> $arquivo
    fi
done

# -- Detector de logins de diferentes IPs --
i=0
consulta="SELECT ip, COUNT(*) c FROM Submissao WHERE respostaInformada = 'submissaoPadrao' GROUP BY ip HAVING c > 1;"
loginsDeDiferentesIPs=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
if [ -n "$loginsDeDiferentesIPs" ]; then
    echo "## Logins de diferentes IPs:" >> $arquivo
else
    echo "Nenhum login de diferentes IPs." >> $arquivo
fi
for linha in $loginsDeDiferentesIPs; do
    if [ $i -eq 0 ]; then
        consulta="SELECT DISTINCT idUsuario FROM Submissao WHERE ip = '$linha' AND respostaInformada = 'submissaoPadrao' ORDER BY hora"
        possiveisTrapaceiros=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
        echo "Máquina $(echo $linha | cut -d' ' -f1) logou com os usuários:" >> $arquivo
        for possivelTrapaceiro in $possiveisTrapaceiros; do
            consulta="SELECT hora FROM Submissao WHERE ip = '$linha' AND idUsuario = $possivelTrapaceiro AND respostaInformada = 'submissaoPadrao'"
            hora=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
            echo "$possivelTrapaceiro às $(echo $hora)" >> $arquivo
        done
        i=1
    else
        i=0
        echo
    fi
done

# -- Detector de possíveis tentativas de brute force --
tempoInicial=$(echo "SELECT MIN(hora) FROM Submissao" | mysql -u root TreasureHunt -N 2> /dev/null)
tempoFinal=$(echo "SELECT MAX(hora) FROM Submissao" | mysql -u root TreasureHunt -N 2> /dev/null)
quantidadeAceitavelDeSubmissoes=$(echo "$quantidadeQuestoes * 2" | bc -l)
consulta="SELECT idUsuario, COUNT(*) AS media FROM Submissao WHERE hora BETWEEN '$tempoInicial' AND '$tempoFinal' GROUP BY idUsuario HAVING media > $quantidadeAceitavelDeSubmissoes ORDER BY media;"
usuariosQueEnviaramMuitasRespostas=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
echo -e "\n" >> $arquivo
if [ -n "$usuariosQueEnviaramMuitasRespostas" ]; then
    echo "## Usuários que enviaram muitas respostas (quantidade de questões * 2):" >> $arquivo
    i=0
    for usuarioID in $usuariosQueEnviaramMuitasRespostas; do
        if [ $i -eq 0 ]; then
            consulta="SELECT COUNT(*) FROM Submissao WHERE idUsuario = $usuarioID"
            quantidadeSubmissoesUsuario=$(echo $consulta | mysql -u root TreasureHunt -N 2> /dev/null)
            mediaPorQuestao=$(echo "$quantidadeSubmissoesUsuario / $quantidadeQuestoes" | bc -l)
            echo "Usuário $usuarioID enviou $quantidadeSubmissoesUsuario respostas durante toda a competição (média de $(formataValorFloat $mediaPorQuestao) por questão)." >> $arquivo
            i=1
        else
            i=0
            echo >> $arquivo
        fi
    done
else
    echo "Nenhum usuário enviou muitas respostas (quantidade de questões * 2)." >> $arquivo
fi

echo -e "\nEstatísticas do banco de dados salvas em: "
echo "$arquivo"
