#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from subprocess import call
import platform
import time

timelog = time.asctime()
timestamp = int(time.time())
log_name = "install_"+str(timestamp)+".log"
call(["touch", log_name])
output=open(log_name, "a")

nome_arquivo="requirements.txt"
if len(sys.argv) >= 2:
	nome_arquivo=sys.argv[1]

arquivo=open(nome_arquivo, "r")
dist = platform.dist()[0]

output.write("Este é um arquivo log gerado automaticamente pelo script.\n")
output.write("O arquivo foi rodado em: "+str(timelog)+"\n\n")
nao_instalados=[]
sucedidos=0

if dist == "Ubuntu" or dist == "debian":
	for linha in arquivo.readlines():
		msg1 = "Instalando pacote: "+str(linha.rstrip())
		print(msg1)
		output.write(msg1+"\n")
		exit_code = call(["sudo", "apt-get", "install", linha.rstrip(), "-y"], stdout=arquivo)
		if exit_code != 0:
			output.write("Instalação não foi bem-sucedida, código do erro: "+str(exit_code)+"\n")
			print("Falha ao instalar pacote:", linha)
			nao_instalados.append(linha)
		else:
			sucedidos+=1
			output.write("Instalação realizada com sucesso!\n")
			print("Pacote instalado: "+str(linha))
		output.write("\n")
else:
	print("Distribuição ainda não é suportada!")
arquivo.close()
output.close()

print()
print("Número de pacotes: ", sucedidos+len(nao_instalados))
print("Número de pacotes não instalados:", len(nao_instalados))
print("Pacotes não instalados:\n"+"".join(nao_instalados))