NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	strings "../$i/$2/Desafio.pyc" | grep -o '.\{41\}' | head -c 40 | base32 -d
	#strings "../$i/$2/Desafio.pyc" | grep -o '.\{42\}' | sed -e 's/^\s*//' -e '/^$/d' | cut -c -32 | base32 -d
done
