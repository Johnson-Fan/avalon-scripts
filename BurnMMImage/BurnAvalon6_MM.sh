#!/bin/bash
while true; do
	make isedir=/home/Xilinx/14.6/ISE_DS erase && \
	sleep 2 && \
	make isedir=/home/Xilinx/14.6/ISE_DS reflash;
echo;
read -p "Press any key to burn next"
done
