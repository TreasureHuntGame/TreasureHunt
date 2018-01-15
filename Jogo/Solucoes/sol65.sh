NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%02x ",$i); print ""; }' "../$i/$2/saida.out" > "../$i/$2/saida"
	xxd -p -r "../$i/$2/saida" "../$i/$2/sai.class"
	strings "../$i/$2/sai.class" | grep TreasureHunt
	rm "../$i/$2/saida" "../$i/$2/sai.class"
done
