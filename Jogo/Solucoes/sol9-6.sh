NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/Desafio.class" | grep -o '.\{41\}' | tail -c 41 | base32 -d
	#strings "../$i/$2/Desafio.class" | grep -o '.\{42\}' | sed -e 's/^\s*//' -e '/^$/d' | base32 -d
done
