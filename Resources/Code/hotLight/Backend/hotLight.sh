#!/bin/bash

# for rasberry pi running Ubuntu
# assumes you have a temperature sensor sending an output to 0x48, and an LED grounded to gpio24

# pulls a set of parameters from a MySQL table, tests the current time and temp against the parameters,
# and gives an alert (via LED, print to terminal, and SMS) if time and temp are not within parameters 
# (colder than too_cold, hotter than too_hot, or later than bedtime)

# sets up the LED's ground pin so we can control the light
echo 24 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio24/direction

declare -i attempt=1000	# attempt is an int counter, starts at 1000 so that if [ attempt -gt 300 ] is executed
wasGood=false # wasGood tracks whether the last check was within bounds

# username, password, and database name for the MySQL db
# (assumes you already have a table temp_table with columns too_cold, too_hot, bedtime, and timestamp,
# and a table records with columns time and temp)
username=YOURUSERNAME
password=YOURPASSWORD
dbname=YOURDATABASE

# message to be sent when it is too cold, too hot, past bedtime, or all parameters are met
too_cold_msg="it's too cold!"
too_hot_msg="it's too hot!"
too_late_msg="it's past bedtime!"
all_good_msg="it's all good, cheif!"

while [ true ]
do
	a=$(i2cget -y 1 0x48)	# here our temp sensor is giving its output to 0x48
	a=$(./hexToDecimal $a)	# hexToDecimal is a c program that converts from a string hex num to a decimal num
							# will have to be compiled and permissions set before use

	now=$(date +"%T")	# current time

	# pull too_cold, too_hot, and bedtime from the mysql database
	# temp_table is the table from which we are pulling the data, ORDER BY timestamp DESC LIMIT 1 ensures the most recent entry is pulled from
	# 2>error.txt redirects the error message from this line, "passing passwords directly from the commandline is insecure"
	# (it is, but we dont need the message printed once a second to the terminal.)
	too_cold=$(mysql $dbname -u $username -$password -se "SELECT too_cold FROM temp_table ORDER BY timestamp DESC LIMIT 1;" 2>error.txt)
	too_hot=$(mysql $dbname -u $username -$password -se "SELECT too_hot FROM temp_table ORDER BY timestamp DESC LIMIT 1;" 2>error.txt)
	bedtime=$(mysql $dbname -u $username -$password -se "SELECT bedtime FROM temp_table ORDER BY timestamp DESC LIMIT 1;" 2>error.txt)

	# if all parameters are met
	if [ ! $a \< $too_cold ] && [ ! $a \> $too_hot ] && [ ! $now \> $bedtime ];
	then
		if [ $wasGood = false ]	# and the parameters used to not be met
		then
			# we keep a record of the time and temp, redirecting the error message as before
			mysql $dbname -u $username -$password -se "INSERT INTO records VALUES ('$now', '$a')" 2>error.txt
			wasGood=true
			echo $now
			echo $all_good_msg	# terminal alert
			python sendMessage.py $all_good_msg	# SMS alert (sendMessage.py just sends the next arg to a predetermined phone number)
			echo 1 > /sys/class/gpio/gpio24/value	# LED alert (this turns the light off)
			sleep 60	# sleep for a minute to ensure that we aren't spamming SMS messages
		fi 
		# if all parameters are met and all parameters were met last check, then the user need not be notified

	else	# if not all parameters are met
		if [ $wasGood = true ]	# and the parameters used to be met
		then
			# take the record
			mysql $dbname -u $username -$password -se "INSERT INTO records VALUES ('$now', '$a')" 2>error.txt

			# depending on the parameter broken, send either the too cold, too hot, or too late message
			if [ $a \< $too_cold ];
            then
                echo $now
            	echo $too_cold_msg
                python sendMessage.py $too_cold_msg
            	sleep 60
            fi

	        if [ $a \> $too_hot ];
            then
            	echo $now
            	echo $too_hot_msg
                python sendMessage.py $too_hot_msg
            	sleep 60
            fi

	        if [ $now \> $bedtime ];
            then
                echo $now
            	echo $too_late_msg
                python sendMessage.py $too_late_msg
            	sleep 60
            fi
			echo 0 > /sys/class/gpio/gpio24/value	# regardless of the message, turn the LED on
			wasGood=false
		fi
	fi	# so far, this took a record and send an alert whenever there was a change of state
		# (was good and now isn't, or was not good and now is)
		# this next section takes a record and sends an alert on a set timer, as a reminder
	if [ $attempt -gt 300 ];	# every ~5 min
	then
		# take another record
		mysql $dbname -u $username -$password -se "INSERT INTO records VALUES ('$now', '$a')" 2>error.txt

		# if it is still too cold, too hot, or past bedtime, send another alert as a reminder
		if [ $a \< $too_cold ];
		then
			echo $now
			echo $too_cold_msg
			python sendMessage.py $too_cold_msg
			sleep 60
		fi

		if [ $a \> $too_hot ];
		then
			echo $now
			echo $too_hot_msg
			python sendMessage.py $too_hot_msg
			sleep 60
		fi

		if [ $now \> $bedtime ];
		then
			echo $now
			echo $too_late_msg
			python sendMessage.py $too_late_msg
			sleep 60
		fi
		attempt=0
	fi	# there doesn't need to be a reminder for if it's all good, because that requires no action on the user's part

	attempt+=1

	sleep 1
done

exit 0
