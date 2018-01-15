# Obtém a solução para todas as instâncias e imprime no terminal
NUM_INSTANCIAS=$1
for i in $(seq 1 $NUM_INSTANCIAS)
do  
	outguess -r "../$i/$2/ronald.jpg" "../$i/$2/saida.txt"
done
for i in $(seq 1 $NUM_INSTANCIAS)
do  
	cat "../$i/$2/saida.txt" | cut -c -22
	rm "../$i/$2/saida.txt"
done
