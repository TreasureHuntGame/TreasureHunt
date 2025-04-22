FROM mysql:5.7

# Correção de erro de SQL para permitir NO_ZERO_DATE (Nota 3)
COPY ./Configuracao/my.cnf /etc/mysql/conf.d/
