start /B minerd -a m7mhash -o stratum+tcp://mining.m-hash.com:3334 -u TashaSkyUp.50 -p !Biago123 & start /B ping 127.0.0.1 -n 6 > nul && wmic process where name="minerd.exe" CALL setpriority 64
pause 