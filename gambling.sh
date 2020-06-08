#!/bin/bash -x

stake=100;
BET=1;
#while Loop Run Until Gambler Loose All stake Upto $1
	while [ $BET -lt $stake ]
	do
		result=$((RANDOM%2));
	 	if [ $result -eq 1 ]
		then
			echo "Win";
			stake=$(($stake+$BET));

		else
			echo "Loose";
			stake=$(($stake-$BET));
		fi
	echo "Final stake"$stake;
	done
