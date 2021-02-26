#!/usr/bin/python3
# ^ that should be the path to your python

import smtplib	# you will almost certainly have to install this before use

sprint = "@messaging.sprintpcs.com"	# this is the address for sprint as of December 2020
# the updated address and addresses for other carriers can be easily found online
# try googling "CARRIER sms gateway"

# a method to send a given string
def send(message):
	to_number = "555-555-5555{}".format(sprint)

	# here we log in to a gmail account to send the messages
	username = "USERNAME"
	password = "PASSWORD"
	server = smtplib.SMTP("smtp.gmail.com", 587)
	server.starttls()
	server.login(username, password)

	# here we are sending an email, from our gmail account, to sprint's sms gateway. sprint then takes the
	# body of the email and actualy sends it to the phone as an sms
	server.sendmail(username, to_number, message)
