format_float_value() {
    printf "%.2f" $1
}

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

echo "# Desempenho da turma"
echo "Media de acertos: $media_acertos"
echo "Desempenho da turma: $desempenho_sem_easteregg%"
echo "Desempenho da turma com o easteregg: $desempenho%"
echo "Quantidade total de submissoes: $quantidade_submissoes"
echo "Quantidade total de submissoes corretas: $quantidade_submissoes_corretas"
echo "Taxa de submissoes corretas: $taxa_submissoes_corretas%"
