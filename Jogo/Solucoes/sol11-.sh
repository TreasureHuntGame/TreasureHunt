NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	exiftool "../$i/$2/saida.out" | grep Treasure | tail -c-34
done
