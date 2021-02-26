<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Temperature Monitor</title>
    </head>
    <body>
        <div class="header">
            <h1>Is it cold in my apartment?</h1>
        </div>
        <p>
            <form action="insert.php" method="post">
                <label for="too_cold">Too Cold At (F):</label>
                <input type="number" name="too_cold" id="too_cold" />
                <label for="too_hot">Too Hot At (F):</label>
                <input type="number" name="too_hot" id="too_hot" />
                <label for="bedtime">Bedtime (24 hr time):</label>
                <input type="number" name="bedtime" id="bedtime" />

                <button type="set">Set</button>
            </form>
        </p>
        <p>
            <a class="dev tools" href="devtools.php">dev tools</a>
        </p>
    </body>
</html>
