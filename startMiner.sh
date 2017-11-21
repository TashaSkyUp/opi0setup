#!/bin/bash
maddr="104.131.5.234"
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

arch="$(uname -m)"
minerDir="wolf$arch"
echo "using full path: $DIR/$minerDir"
cd $DIR/$minerDir

ip="$(hostname -I)"
case $1 in
  "--workername")
  ip="$2"
  echo "using workername $ip"
  ;;
esac

case $ip in
  "")
    echo "no ip detected use --workername"
    exit 0
    ;;
  *)
    echo "using IP $ip"
    machine="$arch$(echo $ip| cut -d'.' -f 4)"
    echo "test $machine $1"
    ;;
esac

case $1 in
"--benchmark")
./minerd -a m7mhash -o stratum+tcp://$maddr:3334 -u TashaSkyUp.$machine -p !Biago123 --benchmark
;;

"--log")
rm -f log
script -c "./minerd -a m7mhash -o stratum+tcp://$maddr:3334 -u TashaSkyUp.$machine -p !Biago123" ../log
;;
"-v")
	./minerd -a m7mhash -o stratum+tcp://$maddr:3334 -u TashaSkyUp.$machine -p !Biago123 
	;;
"--service")
	./minerd -q --syslog --background -a m7mhash -o stratum+tcp://$maddr:3334 -u TashaSkyUp.$machine -p !Biago123
	;;
"--workername")
	./minerd -a m7mhash -o stratum+tcp://mining.m-hash.com:3334 -u TashaSkyUp.$machine -p !Biago123
	;;
*)
	./minerd $1 -a m7mhash -o stratum+tcp://$maddr:3334 -u TashaSkyUp.$machine -p !Biago123
;;
esac
