#include <stdio.h>
void main() {
	int horaOnibus;
	scanf("%i", 	scanf("%i", &horaOnibus);
	if (horaOnibus < 10 || horaOnibus > 19 || horaOnibus == 12 || horaOnibus == 15 || horaOnibus == 17 || horaOnibus == 18)
		printf("Horário inválido\n");
	else {
		if (horaOnibus < 13)
			printf("Não houve atraso\n");
		else
			printf("Houve atraso de %i hora(s) e 45 minuto(s)\n", horaOnibus - 13);
	}
}
