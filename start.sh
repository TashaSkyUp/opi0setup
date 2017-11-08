#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo "$(uname -m)"

d="wolf$(uname -m)"

a="$(service rpimonitor status)"
if [ ${#a} -eq 0 ]
then
a="not-found"
fi

function startMiner {
$DIR/startMiner.sh $1
armbianmonitor -m
}

a="$(echo "$a" | grep "not-found" -o)"
echo "-$a-"

if [ ${#a} -eq 0 ]
then
  echo "rpimonitor is already installed"
else
  echo "not yet installed - will install"

  case "$(uname -m)" in
    "x86_64")
      wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
      apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
      apt-get update
      apt-get install rpimonitor -y --allow-unauthenticated
      ;;
    "armv7l")
      armbianmonitor -r
      ;;
  esac
fi

startMiner $1
