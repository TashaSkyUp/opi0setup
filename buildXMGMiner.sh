#!/bin/bash
arch="$(uname -m)"
echo "-=Arch=($arch)=-"
md="wolf-m7m-cpuminer-V2"

if [ -d $md ];then
#clean make
  cd $md
  make clean
  cd ..
  
#collect make file locations into an array
  cd $md
  mfiles=$(find -name "Makefile")
  for f in $mfiles
      do echo "Makefile $f";
  done
  cd ..
fi
function defaultConfig {
  if [ -e ./$md/Makefile ]
  then
      echo "ok"
  else
    echo "./autogen.sh && ./configure"
    cd $md
     ./autogen.sh
     ./configure
  fi
}
case $1 in
  "--download")
    zypper install automake autoconf make gcc gmp-devel curl-devel
    apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev -y
    git clone https://github.com/magi-project/wolf-m7m-cpuminer-V2
    ;;
  "--replace-a7")
    #needs work see readme in  wolf v2 repo
    cd $md
    ./autogen.sh
    CFLAG="-O2 mfpu=neon-vfpv4" ./configure
    for f in $mfiles; do
      cp  $f $f.old
      sed -i 's/-march=native/-mcpu=cortex-a7/g' $f > $f.old   
      sed -i 's/-flto//g' $f > $f.old 
    done
    ;;
   "--replace-a53")
    #needs work see readme in  wolf v2 repo
    cd $md
    ./autogen.sh
    CFLAG="-O2 -mcpu=cortex-a53+crypto" ./configure
    for f in $mfiles; do
      echo "$f"
      cp  $f $f.old
      sed -i 's/-march=native/-mcpu=cortex-a53+crypto/g' $f > $f.old   
      #sed -i 's/-flto//g' $f > $f.old 
    done    
    make -j4
cd ..
rm wolfaarch64 -r
mv $md wolfaarch64
    ;;
  "--build")
    case $arch in
      "x86_64")
        defaultConfig
        cd $md 
       
        make -j4
      
        echo "verified $arch"
        cd ..
        rm ./wolf$arch -R -f
        cp ./$md ./wolf$arch -R
        rm ./$md -R -f
        ;;
        
        "armv7l")
         defaultConfig
         cd $md 
         make -j4
        
          echo "verified $arch"
          ;;
          
        "aarch64")
        defaultConfig
         cd $md 
         make -j4
        
          echo "verified $arch"
        
        ;;
      esac
esac
