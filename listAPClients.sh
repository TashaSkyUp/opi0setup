#!/bin/bash
arp -n -i wlan0 | grep "172\.24\.1\.[0-9]\+ " -o
