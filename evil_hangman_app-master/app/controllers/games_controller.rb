
include GamesHelper

class GamesController < ApplicationController
  
  #Creates a new game.
  def new
    @game = Game.new
  end

  #Creates a new game and populates the page with the necessary fields 
  def create
    @game = Game.new(game_params)
    @user = current_user
    @game.name = @user.name
    @game.words = "0"
    @game.deaths = "0"
    @game.correct_guesses = "0"
    @game.wrong_guesses = "0"
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

 #Shows the current game with the associated id.
  def show
    @id = params[:id]
    @game = Game.find(params[:id])
  end
 #updates the users stats on the stats page
  def updateStats
    update_hash = params[:update]
    id = update_hash["id"]
    @game = Game.find(id)

    @game.deaths = update_hash["deaths"]
    @game.words = update_hash["solved"]
    @game.correct_guesses = update_hash["correct"]
    @game.wrong_guesses = update_hash["wrong"]
    @game.save

    data = 0
    respond_to do |format|
      format.json { render json: {"value" => data} }
    end
    
  end
#Generates the random word based on difficulty chosen
  def random
    random_hash = params[:difficulty]
    id = random_hash["id"]
    @game = Game.find(id)

    length_of_word=0
    if @game.difficulty == "Easy"
      length_of_word = 4+rand(3)
    elsif @game.difficulty == "Medium"
      length_of_word = 8+rand(3)
    else
      length_of_word = 12+rand(3)
    end

    data = length_of_word
    respond_to do |format|
      format.json { render json: {"value" => data} }
    end

  end
#Updates letter based on correct guesses
  def updateLetter

    guessed_letters = []
    game_over = false
    guesses_left = 15
    word_pattern ="--------"
    puts word_pattern
    length_of_word=8
    words=[]
    

    #get guessed letter from view and add to array
    guess_hash = params[:guessed_letter]
    puts guess_hash

    guessed_letter = guess_hash["letter"].downcase
    guessed_letters.push(guessed_letter)
    guesses_left=guesses_left-1

    word_pattern = guess_hash["word"]
    count = guess_hash["count"]

    length_of_word=word_pattern.length

    id = guess_hash["id"]
    id = id.to_i
    @game = Game.find(id)

    words = @game.words_group

    #creates hash with key value of string letter pattern e.g. "----e---e" and value of a set of all words with that pattern
    evil_guess = Hash.new
    create_word_families(evil_guess,guessed_letter,length_of_word, count,
			words, word_pattern)

    #chooses letter pattern/word family that has the most words in it
    word_pattern = choose_word_family(evil_guess,guessed_letter, word_pattern)

    #determine if word is guessed or not
    letters_correct = get_letter_count(word_pattern,guessed_letter)
    if letters_correct==length_of_word
      puts "GAME OVER"
      game_over=true
    end


    @game.words_group= evil_guess[word_pattern]
    data=word_pattern
    puts word_pattern

    @game.save
    respond_to do |format|
      format.json { render json: {"value" => data} }
    end

  end

  private
    def game_params
      params.require(:game).permit(:name, :difficulty, :words)
    end

end
