import pandas as pd

df = pd.read_csv("dados.csv")

total_questoes = df["quantidadeQuestoes"].sum()
total_submissoes = df["quantidadeSubmissoes"].sum()
total_submissoes_corretas = df["quantidadeSubmissoesCorretas"].sum()

media_media_acertos = df["mediaAcertos"].mean()

num_competicoes = len(df)

desempenho = 100 * total_submissoes_corretas / \
    (total_questoes * num_competicoes)
desempenho_sem_easteregg = 100 * total_submissoes_corretas / \
    ((total_questoes - 1) * num_competicoes)
taxa_submissoes_corretas = 100 * total_submissoes_corretas / total_submissoes

print("===== Desempenho Geral =====")
print(f"Quantidade total de questões: {total_questoes}")
print(f"Quantidade total de submissões: {total_submissoes}")
print(f"Quantidade total de submissões corretas: {total_submissoes_corretas}")
print(f"Média das médias de acertos: {media_media_acertos:.4f}")
print(f"Desempenho geral: {desempenho:.4f}%")
print(f"Desempenho sem easter egg: {desempenho_sem_easteregg:.4f}%")
print(f"Taxa geral de submissões corretas: {taxa_submissoes_corretas:.4f}%")
