// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .


// Test word
var word = "apple";
var id = "";
var new_word = "";
var solved = 0;
var deaths = 0;
var correct = 0;
var wrong = 0;

$(document).ready(function()
	{


		var x;
		var str = "";
		var dash = "";

//		$.ajax("/games/thing")




		
		//get length of the word
		var length = word.length;


		// Creates the dashes at the bottom left of the game screen
		for (x=0; x<length; x++)
		{
			dash = dash+"- ";
		}
		word = document.querySelector("#guessWord").innerHTML;
		id = document.querySelector("#UserId").innerHTML




		var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
		"K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
		"X", "Y", "Z"];

		var imageCount = 2;
		var count = 0;
		var words = ["0"];


		//Adds the click event for all the letter buttons
		for (x=0; x<26; x++)
		{

			// this is using JQuery to find an element with the id of the
			// current letter in the loop (ex. #A)
			str = "#"+alphabet[x];
			$(str).on('click', function()
				{

					// this is getting the id of the element which is just the
					// letter of the button
					var letter = $(this).attr("id");

					// when the button is clicked it should be disabled since
					// the user can only select a letter once
					$(this).prop("disabled", true);
					
					word = document.querySelector("#guessWord").innerHTML;

					count += 1;
					$.ajax({
						async: false, 
						type:"GET",
						url:"/games/updateLetter",
						data: {guessed_letter: {"letter" : letter, "word" :
						word, "count" : count, "id" : id}},
						dataType:"json",
						success: function(data){
							new_word = data["value"];
						},
						failure: function(data){
							window.alert("blerg");
						}
					});


					var temp = "";
					if (word == new_word)
					{
						// rotate the image out to add to the hangman
						str = "/assets/hang"+imageCount+".PNG";
						

						//actually changes the image
						$("#hangmanPic").attr("src", str);

						wrong += 1;
						temp = document.querySelector("#Wrong").innerHTML;
						temp = temp.substring(15, temp.length);
						temp = parseInt(temp)+1;
						temp = "Wrong Quesses: "+temp;
						document.querySelector("#Wrong").innerHTML = temp;
						// this was here for testing purposes but once
						// imageCount gets to then the game is over
						imageCount += 1;
						if (imageCount == 8){
							deaths += 1;
 							temp = document.querySelector("#Deaths").innerHTML;
							temp = temp.substring(8, temp.length);
							temp = parseInt(temp)+1;
							temp = "Deaths: "+temp;
							document.querySelector("#Deaths").innerHTML = temp;
							imageCount = 1;
						}

					
					}else{
						correct += 1;
						temp = document.querySelector("#Correct").innerHTML;
						temp = temp.substring(17, temp.length);
						temp = parseInt(temp)+1;
						temp = "Correct Quesses: "+temp;
						document.querySelector("#Correct").innerHTML = temp;


						// if the letter is in the word group then replaces the
						// the proper dashes with that letter
						document.querySelector("#guessWord").innerHTML =
							new_word;

					}

					var i=0;
					var win=1;
					for (i=0; i<length; i++)
					{
						if (new_word.charAt(i) == "-")
						{
							win = 0;
						}
					}

					if (win==1)
					{
						solved += 1;
						temp = document.querySelector("#Solved").innerHTML;
						temp = temp.substring(14, temp.length);
						temp = parseInt(temp)+1;
						temp = "Solved Words: "+temp;
						document.querySelector("#Solved").innerHTML = temp;
						count = 0;


						window.alert("You did it! The word was "+new_word);
						new_word = "";
						var new_length = 0;
						//call random
						$.ajax({
							async: false, 
							type:"GET",
							url:"/games/random",
							data: {difficulty: {"id" : id}}, 
							dataType:"json",
							success: function(data){
								new_length = data["value"];
							},
							failure: function(data){
								window.alert("blerg");
							}
						});
						for (i=0; i<new_length; i++)
						{
							new_word = new_word+"-";
						}

						for (i=0; i<26; i++)
						{
							str = "#"+alphabet[i];
							$(str).prop("disabled", false);

						}

						imageCount=1;
						// rotate the image out to add to the hangman
						str = "/assets/hang"+imageCount+".PNG";
						

						//actually changes the image
						$("#hangmanPic").attr("src", str);
						imageCount += 1;

						document.querySelector("#guessWord").innerHTML =
							new_word;

					}


					//call random
					$.ajax({
						async: false, 
						type:"GET",
						url:"/games/updateStats",
						data: {update: {"id" : id, "solved": solved, "deaths" :
						deaths, "correct" : correct, "wrong" : wrong}}, 
						dataType:"json",
						success: function(data){
							
						},
						failure: function(data){
							window.alert("blerg");
						}
					});


				});
		}
	});


