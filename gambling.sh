#!/bin/bash -x
declare -a totalWonAmount;
declare -a totalLooseAmount;
WINLOOSEAMOUNT=50;
BET=1;
MINSTAKE=50;
MAXSTAKE=150;
#This is  we calculating for only One Month
		for (( day=1;day<31;day++ ))
		do
			stake=100;
			flag=0;
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
						flag=1;
						break;
					fi;
				else
					echo "Loose";
					stake=$(($stake-$BET));
					if [ $stake -eq $MINSTAKE ]
					then
						echo "=Resigned=";
						echo "Stake At the End of Day="$stake;
						flag=2;
						break;
					fi;
				fi

			done
			
#This is for storing the winning amount of each day in a array
			if [ $flag -eq 1 ]
			then
				totalWonAmount[((day))]=$WINLOOSEAMOUNT;
			else
				totalLooseAmount[((day))]=$WINLOOSEAMOUNT;
			fi;

#Here We Displaying Total amount Win Loose each day after date 20
			if [ $day -ge 20 ]
			then
			echo "TOTAL WON AMOUNT="$(($(printf '%s +' "${totalWonAmount[@]}" )0));
			echo "TOTAL LOOSE AMOUNT="$(($(printf '%s +' "${totalLooseAmount[@]}" )0));
			fi;
							
		done
