NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/Desafio.pyc" | strings | grep -o '.\{33\}' | sed -e 's/^\s*//' -e '/^$/d' | cut -c -32 | base64 -d
done
