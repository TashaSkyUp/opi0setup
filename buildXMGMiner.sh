#!/bin/bash
arch="$(uname -m)"
echo $arch
function defaultConfig {
  if [ -e ./wolf-m7m-cpuminer/Makefile ]
  then
      echo "ok"
  else
    echo "./autogen.sh && ./configure"
    cd wolf-m7m-cpuminer
     ./autogen.sh
     ./configure
  fi
}
case $1 in
  "--download")

    apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev -y
    git clone https://github.com/novaspirit/wolf-m7m-cpuminer
    ;;
  "--replace")
    cd wolf-m7m-cpuminer
    ./autogen.sh
    CFLAG="-O2 mfpu=neon-vfpv4" ./configure

    cp  ./Makefile ./Makefile.old
    cp  ./m7/Makefile ./m7/Makefile.old
  
    sed -i 's/-march=native/-mcpu=cortex-a53/g' ./Makefile
    sed -i 's/-march=native/-mcpu=cortex-a53/g' ./m7/Makefile     
    ;;
 
  "--build")
    case $arch in
      "x86_64")
        defaultConfig
        cd wolf-m7m-cpuminer 
       
        make -j4
      
        echo "verified $arch"
        cd ..
        rm ./wolf$arch -R -f
        cp ./wolf-m7m-cpuminer ./wolf$arch -R
        rm ./wolf-m7m-cpuminer -R -f
        ;;
        
        "armv7l")
         defaultConfig
         cd wolf-m7m-cpuminer 
         make -j4
        
          echo "verified $arch"
          ;;
      esac
esac
