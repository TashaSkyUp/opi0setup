#!/bin/bash
$(curl 172.24.1.1:1880/opi0cluster?register=1)
clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register=1 | cut -d',' -f 2 | cut -d':' -f2 | grep -o "[0-9]*")" 
echo "$clusterNumber" > /clusterNumber
