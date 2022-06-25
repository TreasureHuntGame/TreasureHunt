NUM_INSTANCIAS=$1
for i in $(seq $NUM_INSTANCIAS)
do
	cat "../$i/$2/index.html" | grep -o "<!--.*" | cut -c 6- | rev | cut -c 5- | rev | awk '{ for(i=1;i<=NF;i++) printf("%c",$i); print ""; }' | sed -n 's/.*\(TreasureHunt\)/\1/p' | cut -c -20
done
