# TwitterBot

a simple bot for twitter. tweets out lines from a file one at a time at a preset interval.


before you use:

1. make sure that twitter4j is added to your classpath. in IntelliJ, this can be done by going to File>Project Structure>Libraries, clicking on the '+' icon, and adding from maven the library org.twitter4j:twitter4j-core:4.0.722

how to use:

1. create a twitter account for the bot. I already have one set up here: <img=README_Support/TestBot421.png>
note: you will need a verified phone number and email to sign up for a dev account, so make sure you use that here

2. sign up for a developer account using the twitter account for the bot.
    a. navigate to https://developer.twitter.com/en/apply-for-access and sign in with your bot's account
    b. click "apply for access" and fill out the required fields; you will need to fill out a few fields about how you plan to use the bot and agree to the developer agreement

3. You should get a confirmation email with a link to create your new project. Approval may take some time, but I was given a link to a site that looks like this immediately. <img=README_Support/NameProject.png>

4. After naming your project, you will be given a set of keys. copy and paste these API keys into your twitter4j.properties file, replacing YOUR_CONSUMER_KEY and YOUR_CONSUMER_SECRET

5. now go to the main dashboard, where you should see your project. <img=README_Support/Dashboard.png> click on the key icon next to your project name, and generate an access token. copy and pase these access tokens into your twitter4j.properties file, replacing YOUR_ACCESS_TOKEN and YOUR_ACCESS_SECRET <img=README_Support/GenerateAccessToken.png> note: here it says "created with Read Only permissions" THIS IS NOT WHAT YOU WANT. if your key has been created with read only permissions, go to the settings tab and give the app read and write permissions, then regenerate the key.

6. now that oauth is all set up, simply add tweets into tweets.txt and run. tweets should be contained all on one line; each line is considered a seperate tweet. make sure to make a copy of tweets.txt, because there is a slight chance of the file being corrupted or deleted if the program is shut off at the wrong time, but this is highly unlikely.

7. by default, the tweets are sent once every 15 minutes. if you would like to change this, go to thread.sleep() in tweetLines() and change the number of milliseconds that the thread waits for