import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

import java.io.*;
import java.util.*;
import java.nio.file.Files;

public class TwitterBot {

    public static boolean fileEmpty = false;

    /**
     * main method, drives tweetLines() until the file is empty
     * @param args
     */
    public static void main(String[] args) {
        while(!fileEmpty) {
            tweetLines();
        }
    }


    /**
     * a method to tweet the lines from a file (currently resources/tweets.txt) a line at a time, skipping blank lines
     * after the tweet attempt was made, updates the file to remove the line just processed and sleeps for some time
     * @return true if the tweet was successfully sent, else false
     */
    private static boolean tweetLines() {
        boolean success = false;
        String line;
        try {
            // this file path may need to be changed, depending on how the program is run. I have it running
            // as an IntelliJ Application, which means the current directory is the project directory,
            // not the directory that contains TwitterBot.class
            File inFile = new File("resources/tweets.txt"); // this is the file where you should put
            Scanner input = new Scanner(inFile);                       // your tweets
            if (input.hasNextLine()) {  // if the file is not empty

                do {    // skip through all the blank lines
                    line = input.nextLine();
                } while (line.equals(""));

                // we captured our next non-blank line, now try to tweet it
                if (sendTweet(line) != null) {  // if the tweet fails, it sendTweet will return null
                    // alert the user that the tweet went through
                    System.out.println("Tweeting: " + line + "...");
                    success = true;
                } else {
                    System.out.println("Tweet failed!");
                }

                // this section just removes the tweet that was just made from tweets.txt
                // that way, if the program is stopped, next time it is run it will start from where it left off
                // there is a slight (very very slight) chance that the program is stopped in the middle of
                // copying tweets.txt, in which case tweets.txt may be corrupted or deleted. make sure to have a
                // backup somewhere (again, this is very unlikely)
                File outFile = new File("resources/tweetsCopy.txt");
                PrintStream output = new PrintStream(outFile);
                while (input.hasNext()) {       // we are basically just copying every line after the one we just
                    line = input.nextLine();    // tweeted into a separate file
                    output.println(line);
                }
                inFile.delete();                // deleting the original file
                Files.copy(outFile.toPath(), inFile.toPath());  // copying our new file back into tweets.txt
                outFile.delete();               // and deleting the file we used to do the copying
                System.out.println("file copied."); // if the program is stopped between the tweeting notification
                input.close();                      // and this notification, tweets.txt might be lost
                output.close();

                // now sleep for some amount of time
                try {
                    System.out.println("Sleeping...");
                    Thread.sleep(900000);   // 900,000ms is 15 min
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }

            } else {    // if the file is empty
                fileEmpty = true;   // this will end the tweeting
                System.out.println("Out of Tweets!");   // alert the user
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return success; // true if the tweet was sent, else false
    }


    /**
     * method to tweet a String, logs in using the info in twitter4j.properties and tweets
     * @param line the line to tweet
     * @return the status, null if failed
     */
    private static Status sendTweet(String line) {
        Twitter twitter = TwitterFactory.getSingleton();
        Status status;
        try {
            status = twitter.updateStatus(line);
        } catch (TwitterException e) {;
            e.printStackTrace();
            status = null;
        }
        return status;
    }

}