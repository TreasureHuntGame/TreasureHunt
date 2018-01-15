NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' "../$i/$2/saida.out" | base64 -d > "../$i/$2/dados.dat"
	cat "../$i/$2/dados.dat" | grep -a --text TreasureHunt | tail -c -24
	rm "../$i/$2/dados.dat"
done
