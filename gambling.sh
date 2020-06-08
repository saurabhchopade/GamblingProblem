#!/bin/bash -x

stake=100;
BET=1;
MINSTAKE=50;
MAXSTAKE=150;
#while Loop Run Until Gambler win or loose 50 percent
	while :
	do
		result=$((RANDOM%2));
	 	if [ $result -eq 1 ]
		then
			echo "Won";
			stake=$(($stake+$BET));
				if [ $stake -eq $MAXSTAKE ]
				then
					echo "=Resigned=";
					echo "Stake At the End Of Day="$stake;
					exit 1;
				fi;
		else
			echo "Loose";
			stake=$(($stake-$BET));
				if [ $stake -eq $MINSTAKE ]
				then
					echo "=Resigned=";
					echo "Stake At the End of Day="$stake;
					exit 1;
				fi;
		fi

	echo "Final stake="$stake;
	done
