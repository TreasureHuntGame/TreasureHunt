NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	awk '{ for(i=1;i<=NF;i++) printf("%02x ",$i); print ""; }' "../$i/$2/saida.out" > "../$i/$2/saida"
	xxd -p -r "../$i/$2/saida" "../$i/$2/img.jpg"
	outguess -r "../$i/$2/img.jpg" "../$i/$2/sai"
done
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/sai" | cut -c -22
	rm "../$i/$2/saida" "../$i/$2/sai" "../$i/$2/img.jpg"
done
