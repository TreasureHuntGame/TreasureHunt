# Obtém a solução para todas as instâncias e imprime no terminal
NUM_INSTANCIAS=$1
for i in $(seq 1 $NUM_INSTANCIAS)
do  
	outguess -k $i -r "../$i/$2/ronald.jpg" "../$i/$2/saida1.txt"
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/saida2.txt"
done

RESPOSTA=$(grep "Trea" "../$i/$2/saida1.txt" | wc -l)
if [ $RESPOSTA -eq 0 ]
	then RESPOSTA=2
	else RESPOSTA=1
fi

for i in $(seq 1 $NUM_INSTANCIAS)
do  
	cat "../$i/$2/saida$RESPOSTA.txt" | cut -c -22
	rm "../$i/$2/saida1.txt" "../$i/$2/saida2.txt"
done
