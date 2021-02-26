# SampleApp_Mac
template for creating a MacOS app from a JAR file

<b>How to use:</b>

  1) Download the directory(duh) and a version of java (preferably a JRE)
    
    note: if this app is for non-personal use, make sure to liscence the correct version of Java, and/or rely on the user's installation
  
  2) right-click "App.app" (might display as simply "App") and select "show package contents"
  
  3) copy the java folder you just installed and place it into the App.app directory under Contents > MacOS (and delete the empty folder jdk-12.0.2.jdk, it is just a placeholder)
  
  4) go to Contents > Resources and replace "application.icns" with the desired app icon (and name it "application.icns")
    
    4a. if for whatever reason you don't want your icon to be called application.icns, go to Info.plist
    and under "<key>CFBundleIconFile</key>", where it says "<string>application.icns</string>", change "application.icns" to "<yourIconFile.icns>"
    
  5) go to Contents > MacOS and replace "SampleApp.jar" with the .jar file of your app
  
  6) open "launcher" with any text editor
  
    6a. under "# Constants" replace APP_JAR="SampleApp.jar" with APP_JAR="<yourFile.jar>"
  
    6b. in the next line, replace APP_NAME="Sample" with APP_NAME="<yourAppName>"
    
    6c. under "# Set Java version", replace _java="$DIR/jdk-12.0.2.jdk/Contents/Home/bin/java" with the path of your java installation 
    (specifically, the path to the executable file "java", should look like "$DIR/<yourJavaFolderName>/Contents/Home/bin/java", but that is using a JDK, it might look slightly different on a JRE)
    
  7) now, "App.app" (you should rename it now, if you haven't already) should display your app icon and run your .jar file when clicked on
  
  
