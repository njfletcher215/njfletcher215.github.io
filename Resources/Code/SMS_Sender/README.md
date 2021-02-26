# SMS_Sender

Instructions:

1. replace "#!/usr/bin/python3" with the path to your python interpreter in both files
2. install sys and smtplib if you don't already have them

in SMS.py:
3. replace "@messaging.sprintpcs.com" with your carrier's updated gateway (if you have sprint, this is up-to-date as of 2020)
4. replace "555-555-5555" with your phone number (or another number you want to send texts too)
5. replace "USERNAME" and "PASSWORD" with the username and password of a gmail account you control

To Use, either use the bash command "python sendMessage.py 'this is your message'" while in a directory with sendMessage.py (SMS.py should also be in the same directory) or create your own python script that utilizes SMS's send(message) function.
