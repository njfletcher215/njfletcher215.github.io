# hotLight

A temperature monitor for Raspberry Pi running Ubuntu. Tracks the temperature and notifies the user when it changes. Notifications are done using an SMS module (included here) which can also be found under its own directory (SMS_Sender).

The files in Frontend should be moved to the www folder of Apache2 on the pi before use. See each file for more setup information (you will need MySQL set up on the pi, and will need to create a specific set of tables and plug the sensor into specific GPIO pins for it to work properly in its current state).
