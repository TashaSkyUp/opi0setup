#!/bin/bash
arp -i wlan0 | grep "172.24.1.[1-9]\+" -o
