# Instalação no Arch Linux

A instalação ainda não pode ser feita utilizando o _script_ `instalador.sh` presente no diretório `Instalador`.
Para você instalar o _software_, é necessário fazer manualmente seguindo as seguintes instruções.

Primeiramente, assegure-se que você tenha o _yay_ instalado em sua máquina. Veja: [https://github.com/Jguer/yay](https://github.com/Jguer/yay).

```bash
yay -Syu
```

Instale os requisitos providos pelo pacman:
```bash
sudo pacman -S - < requisitos_arch_pacman.txt
```

Instale os requisitos restantes pelo yay:
```bash
yay -S $(cat requisitos_arch_yay.txt)
```

## Configuração do MariaDB
Diferente de outras distribuições Linux, o Arch Linux tem como implementação
padrão para o MySQL o [MariaDB](https://en.wikipedia.org/wiki/MariaDB), um _fork_ do MySQL.

Mesmo sendo tecnicamente diferente do MySQL, ainda é possível a utilização do _TreasureHunt_ normalmente,
pois o MariaDB tem compatibilidade com o MySQL.
Para configuração veja: [https://wiki.archlinux.org/title/MariaDB](https://wiki.archlinux.org/title/MariaDB)

Após a configuração inicial, caso não consiga acessar o MariaDB utilizando `mariadb -u root`, use `sudo mariadb`.
Dentro do MariaDB:
```sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
exit
```
Deixe o campo _new_password_ vazio caso queira que seja possível acessar o usuário root sem senha
(Recomendado caso seja apenas um desenvolvedor). Agora `sudo systemctl restart mariadb.service`

## Configuração do Apache
Veja [https://wiki.archlinux.org/title/Apache_HTTP_Server](https://wiki.archlinux.org/title/Apache_HTTP_Server).

Em várias distribuições Linux, o Apache utiliza `/var/www/html/` como diretório padrão para seu conteúdo.
Já no Arch, o diretório padrão para o conteúdo é o `/srv/http/`.
No _script_ `Jogo.sh`, presente no diretório `Jogo/Scripts/` temos as seguintes linhas:
```bash
DESTINO_DESAFIOS="/var/www/html/TreasureHunt/Desafios/"
CAMINHO_SITE="/var/www/html/TreasureHunt"
```
Você tem duas opções:
1. Modificar as variáveis `DESTINO_DESAFIOS` e `CAMINHO_SITE` no script citado.
2. Modificar o diretório de conteúdo nas configurações do Apache. Veja
[https://wiki.archlinux.org/title/Apache_HTTP_Server#Advanced_options](https://wiki.archlinux.org/title/Apache_HTTP_Server#Advanced_options)

É preferível a 2 opção. Caso faça essa escolha lembre-se de criar o diretório `/var/www/html/`
antes de mudar a configuração no Apache.

Obs.: Caso o PHP não esteja funcionando com o Apache veja
[https://wiki.archlinux.org/title/Apache_HTTP_Server#PHP](https://wiki.archlinux.org/title/Apache_HTTP_Server#PHP)

## Driver MariaDB/MySQL no PHP
Veja [https://wiki.archlinux.org/title/PHP#MySQL/MariaDB](https://wiki.archlinux.org/title/PHP#MySQL/MariaDB)
