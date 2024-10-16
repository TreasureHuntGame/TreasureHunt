#!/bin/bash

format_float_value() {
    printf "%.2f" $1
}

usuario=$1
timestamp=$2

echo -e "--------------------\nScript de geração de estatísticas\n--------------------\n"

# Verifica se o serviço mysql está rodando
if [ "$(systemctl is-active mysql)" != "active" ]; then
    echo "O serviço mysql não está rodando" >&2
    exit 1
fi

query="SELECT COUNT(DISTINCT idProblema) FROM Resposta"
quantidade_questoes=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)

query="SELECT SUM(tentativas) FROM Resposta"
quantidade_submissoes=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)

query="SELECT SUM(acertou) FROM Resposta"
quantidade_submissoes_corretas=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)

query="SELECT COUNT(DISTINCT idUsuario) FROM Submissao WHERE respostaInformada = 'submissaoPadrao'"
quantidade_usuarios=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)

media_acertos=$(echo "$quantidade_submissoes_corretas / $quantidade_usuarios" | bc -l)

desempenho=$(echo "100 * ($quantidade_submissoes_corretas / ($quantidade_questoes * $quantidade_usuarios))" | bc -l)
desempenho_sem_easteregg=$(echo "100 * ($quantidade_submissoes_corretas / (($quantidade_questoes - 1) * $quantidade_usuarios))" | bc -l)
taxa_submissoes_corretas=$(echo "100 * $quantidade_submissoes_corretas / $quantidade_submissoes" | bc -l)

media_acertos=$(format_float_value $media_acertos)
desempenho=$(format_float_value $desempenho)
desempenho_sem_easteregg=$(format_float_value $desempenho_sem_easteregg)
taxa_submissoes_corretas=$(format_float_value $taxa_submissoes_corretas)

arquivo="/home/$usuario/th-relatorios/$timestamp/relatorio_bd.md"

mkdir -p /home/$usuario/th-relatorios/$timestamp
echo -e "# Desempenho da turma\n" > $arquivo
echo "Media de acertos: $media_acertos" >> $arquivo
echo "Desempenho da turma: $desempenho_sem_easteregg%" >> $arquivo
echo "Desempenho da turma com o easteregg: $desempenho%" >> $arquivo
echo "Quantidade total de submissoes: $quantidade_submissoes" >> $arquivo
echo "Quantidade total de submissoes corretas: $quantidade_submissoes_corretas" >> $arquivo
echo "Taxa de submissoes corretas: $taxa_submissoes_corretas%" >> $arquivo

# -- Detector de respostas repetidas (possivelmente plagiadas) --
query="SELECT respostaInformada, COUNT(*) c FROM Submissao WHERE respostaInformada != 'submissaoPadrao' GROUP BY respostaInformada HAVING c > 1;"
respostas_repetidas=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
i=0
echo -e "\n" >> $arquivo
echo "# Análise de Comportamentos Suspeitos e Ataques Potenciais" >> $arquivo
if [ -n "$respostas_repetidas" ]; then
    echo "## Respostas repetidas:" >> $arquivo
else
    echo "Nenhuma resposta repetida." >> $arquivo
fi
for resposta in $respostas_repetidas; do
    if [ $i -eq 0 ]; then
        query="SELECT DISTINCT idUsuario FROM Submissao WHERE respostaInformada = '$resposta' ORDER BY hora"
        cheaters=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
        echo "Resposta '$resposta':" >> $arquivo
        for cheater in $cheaters; do
            query="SELECT idProblema, hora FROM Submissao WHERE respostaInformada = '$resposta' AND idUsuario = $cheater"
            line=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
            echo "Usuário $cheater enviou a resposta $resposta para o problema $(echo $line | cut -d' ' -f1) às $(echo $line | cut -d' ' -f2,3)" >> $arquivo
        done
        i=1
    else
        i=0
        echo >> $arquivo
    fi
done

# -- Detector de logins de diferentes máquinas --
i=0
query="SELECT ip, COUNT(*) c FROM Submissao WHERE respostaInformada = 'submissaoPadrao' GROUP BY ip HAVING c > 1;"
logins_de_diferentes_maquinas=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
if [ -n "$logins_de_diferentes_maquinas" ]; then
    echo "## Logins de diferentes máquinas:" >> $arquivo
else
    echo "Nenhum login de diferentes máquinas." >> $arquivo
fi
for line in $logins_de_diferentes_maquinas; do
    if [ $i -eq 0 ]; then
        query="SELECT DISTINCT idUsuario FROM Submissao WHERE ip = '$line' AND respostaInformada = 'submissaoPadrao' ORDER BY hora"
        cheaters=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
        echo "Máquina $(echo $line | cut -d' ' -f1) logou com os usuários:" >> $arquivo
        for cheater in $cheaters; do
            query="SELECT hora FROM Submissao WHERE ip = '$line' AND idUsuario = $cheater AND respostaInformada = 'submissaoPadrao'"
            hora=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
            echo "$cheater às $(echo $hora)" >> $arquivo
        done
        i=1
    else
        i=0
        echo
    fi
done

# -- Detector de possíveis tentativas de brute force --
tempo_comeco=$(echo "SELECT MIN(hora) FROM Submissao" | mysql -u root TreasureHunt -N 2> /dev/null)
tempo_fim=$(echo "SELECT MAX(hora) FROM Submissao" | mysql -u root TreasureHunt -N 2> /dev/null)
quantidades_de_envios_aceitaveis=$(echo "$quantidade_questoes * 2" | bc -l)
query="SELECT idUsuario, COUNT(*) AS media FROM Submissao WHERE hora BETWEEN '$tempo_comeco' AND '$tempo_fim' GROUP BY idUsuario HAVING media > $quantidades_de_envios_aceitaveis ORDER BY media;"
usuarios_que_enviaram_muitas_respostas=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
echo -e "\n" >> $arquivo
if [ -n "$usuarios_que_enviaram_muitas_respostas" ]; then
    echo "## Usuários que enviaram muitas respostas (quantidade de questões * 2):" >> $arquivo
    i=0
    for usuario_id in $usuarios_que_enviaram_muitas_respostas; do
        if [ $i -eq 0 ]; then
            query="SELECT COUNT(*) FROM Submissao WHERE idUsuario = $usuario_id"
            quantidade_submissoes_usuario=$(echo $query | mysql -u root TreasureHunt -N 2> /dev/null)
            media_por_questao=$(echo "$quantidade_submissoes_usuario / $quantidade_questoes" | bc -l)
            echo "Usuário $usuario_id enviou $quantidade_submissoes_usuario respostas durante toda a competição (média de $(format_float_value $media_por_questao) por questão)." >> $arquivo
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
