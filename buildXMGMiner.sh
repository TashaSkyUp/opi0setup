#!/bin/bash
case $1 in
  "--download")
    arch="$(uname -m)"
    apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev -y
    git clone https://github.com/novaspirit/wolf-m7m-cpuminer
    ;;
  "--replace")
    cp  ./wolf-m7m-cpuminer/Makefile ./wolf-m7m-cpuminer/Makefile.old
    cp  ./m7/wolf-m7m-cpuminer/Makefile ./m7/wolf-m7m-cpuminer/Makefile.old
  
    sed -i 's/-march=native/-mcpu=cortex-a53/g'  ./wolf-m7m-cpuminer/Makefile
    sed -i 's/-march=native/-mcpu=cortex-a53/g' ./wolf-m7m-cpuminer/m7/Makefile
    ;;
 
  "--build")
    case $arch in
      "x86_64")
        cd wolf-m7m-cpuminer 
        ./autogen.sh
        ./configure
        make -j4
      
        echo "verified $arch"
        cd ..
        rm ./wolf$arch -R -f
        cp ./wolf-m7m-cpuminer ./wolf$arch -R
        rm ./wolf-m7m-cpuminer -R -f
        ;;
        
        "armv7l")
         cd wolf-m7m-cpuminer 
         ./autogen.sh
         CFLAG="-O2 mfpu=neon-vfpv4" ./configure
         make -j4
        
          echo "verified $arch"
          ;;
      esac
esac
