#Evil Hangman
To start the game you must first have Ruby installed followed by Rails.

To run the provided tests, enter the command:

	rake tests

This will show results of all unit and integration tests written for this application.

Now we proceed with the game setup...
1. Type the following command to start the game

	rails server

If needed add a -p 3001 if the normal 3000 port is in use.


2. Proceed in a browser to the following link...
	
	http://localhost:3000

or 3001 if event in step 2 happens.

3. On the home page click the Log in in the upper right hand corner.

4. On the login page, click the sign up link and proceed to create an account (or sign in if an account previously exists).

5. Once you login or create an account, click Game in the upper right hand corner of the page to proceed to the game.

6. On the game page, choose a difficutly (Easy, Medium, or Hard). This will take you to the game and the generated word will be a random length within a certain range based on the chosen difficulty. 

7. Click a letter to choose your guess for the word. If the guess is wrong then the hangman images will begin filling the page. If the word isn't guessed within 6 attempts, then the game ends. You can quit the game by clicking quit which will redirect you to the home page. Death's are counted each time you max the guesses. Wins occur when you get the word correct. The game resets with a new word after victory. Be warned that even easy difficulty can be challenging with small word sizes.

8. While logged in, a player can check the leader boards for number of wins each player obtained based on difficulty.

9. The player should log off by clicking Account then Log Off to end playing and return to the home page.

Images in this game belong to the site http://www.flashbynight.com/tutes/hangmanhtml5/. These images are used for educational use only. 	
