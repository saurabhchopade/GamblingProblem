
#!/bin/bash -x
WINLOOSEAMOUNT=50;
BET=1;
MINSTAKE=50;
MAXSTAKE=150;
#This Loop For months if gambler won in previous month
#We Are Storing Win Loose History of One Month In array
	while :
	do
		#Storing Loose won Amount Of each Day
		declare -a totalWonAmount;
		declare -a totalLooseAmount;
		#for Lucky Unlucky
		noWonDays=0;
      noLooseDays=0;
		dummyLuckyCount=0;
		dummyUnluckyCount=0;
		luckyCount=0;
		unluckyCount=0;
		luckyDay=0
		unluckyDay=0;

		for (( day=1;day<31;day++ ))
		do
			stake=100;
			#flag for won or loose
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


#This is for storing the winning and loosing amount of each day in a array
#AND For finding Lucky Unlucky Day using counters	
			if [ $flag -eq 1 ]
			then
				totalWonAmount[((day))]=$WINLOOSEAMOUNT;

				#LUCKY COUNT LOGIC 
				dummyUnluckyCount=0;
				((dummyLuckyCount++));
				if [ $dummyLuckyCount -gt $luckyCount ]
				then
					luckyCount=$dummyLuckyCount;
					#storing latest lucky day
					luckyDay=$day;
				fi;
			else
				totalLooseAmount[((day))]=$WINLOOSEAMOUNT;

				#UNLUCKY COUNT LOGIC
				dummyLuckyCount=0;
				((dummyUnluckyCount++));
				if [ $dummyUnluckyCount -gt $luckyCount ]
				then
					unluckyCount=$dummyUnluckyCount;
					#storing latest Unlucky day 
					unluckyDay=$day;
				fi;
			fi;
			
			echo -e "\n";
#Here We Displaying Total amount Win Loose each day after date 20
			if [ $day -ge 20 ]
			then
			echo -e "\n";
			echo "TOTAL WON AMOUNT="$(($(printf '%s +' "${totalWonAmount[@]}" )0));
			echo "TOTAL LOOSE AMOUNT="$(($(printf '%s +' "${totalLooseAmount[@]}" )0));
			fi;							
		done

#Here Days loop Ended
#Here We  displaying Count Of total Winning or Loosing  Day In Month At End Of Month
		echo -e "\n";
		echo "Count Of Winning Days="${#totalWonAmount[@]} "BY= "$(($( printf '%s +' "${totalWonAmount[@]}" )0));
		echo "Count Of Loose Days="${#totalLooseAmount[@]} "BY="$(($( printf '%s +' "${totalLooseAmount[@]}" )0));

#LUCKIEST DAY UNLUCKIET DAY AND THEIR WON AND LOOSE AMOUNT
		echo -e "\n";
		echo "LUCKYDAY is=" "DAY"$luckyDay  "Max Winning  Amount="$(( $WINLOOSEAMOUNT * $luckyCount));
		echo "UNLUCKYDAY is=" "DAY"$unluckyDay  "Max Loose Amount="$(( $WINLOOSEAMOUNT * $unluckyCount));

#Here we check Gambler allowed to play next month or not
#By Using Array Element We calculating winning and Loose Days
		noWonDays=${#totalWonAmount[@]};
		noLooseDays=${#totalLooseAmount[@]};

		if [ $noWonDays -gt $noLooseDays ]
		then
			read -p "DO YOU WANT TO PLAY NEXT MONTH Press (y)" response;
			if [ "$response" = "y" ]
			then
				echo "Welcome To Next Month";
			else
				break;
			fi;
		else
			echo "YOU NOT Allowed To Play Next Month";
			break;
		fi;
	#To free Array Memory Beacause I have faced Array Overlapping Problem
	unset totalWonAmount;
	unset totalLooseAmount;
	done
