function findToArray {
	#cd /
	#echo "$1"
	#echo "$2"
	echo "$(find / -name "$1")" > tmp.tmp && readarray $2 < tmp.tmp
	rm tmp.tmp
	}
