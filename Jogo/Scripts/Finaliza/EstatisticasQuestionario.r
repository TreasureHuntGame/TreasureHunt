library(psych)

args <- commandArgs(trailingOnly = TRUE)
arquivo <- args[1]

quest <- read.table(arquivo, header=TRUE)

satisf <- quest[, c("Q11", "Q12", "Q13", "Q15", "Q17")]
alfa.satisf <- psych::alpha(satisf, na.rm = T, check.keys = T)
alfa.satisf.coef <- alfa.satisf$total$raw_alpha
conscient <- quest[, c("Q16", "Q21")]
alfa.consc <- psych::alpha(conscient, na.rm = T)
alfa.consc.coef <- alfa.consc$total$raw_alpha
dific <- quest[, c("Q31", "Q32")]
alfa.dific <- psych::alpha(dific, na.rm = T)
alfa.dific.coef <- alfa.dific$total$raw_alpha
motiv <- quest[, c("Q41", "Q42")]
alfa.motiv <- psych::alpha(motiv, na.rm = T)
alfa.motiv.coef <- alfa.motiv$total$raw_alpha


cat("## Satisfação\n")
cat("O coeficiente α de Cronbach é α = ", alfa.satisf.coef, "\n")
cat("## Conscientização\n")
cat("O coeficiente α de Cronbach é α = ", alfa.consc.coef, "\n")
cat("## Dificuldade\n")
cat("O coeficiente α de Cronbach é α = ", alfa.dific.coef, "\n")
cat("## Motivação\n")
cat("O coeficiente α de Cronbach é α = ", alfa.motiv.coef, "\n")

questoes=c()
mediasPre=c()
mediasPos=c()
evolucoes=c()
significativas=c()

# Q11
questoes <- c(questoes, "1.1")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q11pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q11)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q11))-mean(na.omit(quest$Q11pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q11pre, quest$Q11, paired = TRUE)$p.value < 0.05)

# Q12
questoes <- c(questoes, "1.2")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q12pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q12)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q12))-mean(na.omit(quest$Q12pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q12pre, quest$Q12, paired = TRUE)$p.value < 0.05)

# Q13
questoes <- c(questoes, "1.3")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q13pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q13)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q13))-mean(na.omit(quest$Q13pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q13pre, quest$Q13, paired = TRUE)$p.value < 0.05)

# Q14
questoes <- c(questoes, "1.4")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q14pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q14)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q14))-mean(na.omit(quest$Q14pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q14pre, quest$Q14, paired = TRUE)$p.value < 0.05)

# Q15
questoes <- c(questoes, "1.5")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q15pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q15)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q15))-mean(na.omit(quest$Q15pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q15pre, quest$Q15, paired = TRUE)$p.value < 0.05)

# Q16
questoes <- c(questoes, "1.6")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q16pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q16)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q16))-mean(na.omit(quest$Q16pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q16pre, quest$Q16, paired = TRUE)$p.value < 0.05)

# Q17
questoes <- c(questoes, "1.7")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q17pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q17)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q17))-mean(na.omit(quest$Q17pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q17pre, quest$Q17, paired = TRUE)$p.value < 0.05)

# Q21
questoes <- c(questoes, "2.1")
mediasPre <- c(mediasPre, round(mean(na.omit(quest$Q21pre)), digits = 2))
mediasPos <- c(mediasPos, round(mean(na.omit(quest$Q21)), digits = 2))
evolucoes <- c(evolucoes, round(mean(na.omit(quest$Q21))-mean(na.omit(quest$Q21pre)), digits = 2 ))
significativas <- c(significativas, t.test(quest$Q21pre, quest$Q21, paired = TRUE)$p.value < 0.05)

df <- data.frame(Questão=questoes, Pré=mediasPre, Pós=mediasPos, Evolução=evolucoes, Significativa=significativas)
print(df)
