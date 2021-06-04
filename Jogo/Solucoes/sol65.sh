NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%02x ",$i); print ""; }' "../$i/$2/saida.out" | xxd -p -r | strings | grep Treasure
done
