SAIDA=$2
FLAG="TreasureHunt{$(cat /dev/urandom | tr -cd 'a-zA-Z' | head -c 19)}"

if [ $1 -eq 10 ]
	then 
		qrencode $FLAG -o "$SAIDA"
	else
		FAKEFLAG=$(cat /dev/urandom | tr -cd 'a-zA-Z' | head -c 19)
		qrencode $FAKEFLAG -o "$SAIDAprovisorio.png"
		convert "$SAIDAprovisorio.png" "$SAIDA.jpg"
		exiftool -author="$FLAG" "$SAIDA.jpg"
		mv "$SAIDA.jpg" "$SAIDA"
		rm "$SAIDAprovisorio.png" "$SAIDA.jpg_original"
fi