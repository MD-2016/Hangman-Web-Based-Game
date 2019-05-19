module GamesHelper

  #creates a word families based on the words in the dictionary text file.
  def create_word_families(evil_guess,guessed_letter, length_of_word, count,
		  words, word_pattern)
    if (count == "1")
      words = File.read(File.expand_path(Rails.root.join('app','data','dictionary.txt'))).split
      words=words.select{|word| word.length==length_of_word}
    end
#	puts "WORDS"
#	puts words
    words.each do |word|
      letter_pattern = get_string(guessed_letter,word, word_pattern)
      word_family=[]
      if evil_guess.has_key? letter_pattern
        word_family=evil_guess[letter_pattern]
      end
      word_family.push(word)
      evil_guess[letter_pattern]=word_family
    end
  end

  #Creates a family of words where each correct guess will resize the words in the set until the correct word is found.
  def choose_word_family(evil_guess, guessed_letter, word_pattern)
    max_count=0
    correct_word_pattern=""
    key_set = evil_guess.keys
    key_set.each do |current_word_pattern|
      length = evil_guess[current_word_pattern].length
      if length>max_count
        max_count=length
        correct_word_pattern = current_word_pattern
      end
    end
#	puts "Correct   "+correct_word_pattern
#	puts word_pattern


    word_pattern=merge_patterns(correct_word_pattern,word_pattern)
    return word_pattern
  end

  #
  def get_string(guessed_letter,word,word_pattern)
    letter_position=""
    letters = word.split("")
	size = word_pattern.length
#    letters.each do |current_letter|
	size.times do |i|
      if word[i] == guessed_letter
        letter_position = letter_position + guessed_letter
      else
        letter_position = letter_position + word_pattern[i]
      end
    end
    return letter_position
  end

  #
  def merge_patterns(new_word_pattern,word_pattern)
    letter_array=word_pattern.split("")
    new_letter_array=new_word_pattern.split("")
    updated_word_pattern=""
	size = word_pattern.length
    size.times do |i|
      if word_pattern[i]!=new_word_pattern[i] && new_word_pattern[i]!='-'
        updated_word_pattern=updated_word_pattern+new_word_pattern[i]
      else
        updated_word_pattern=updated_word_pattern+word_pattern[i]
      end
    end
    return updated_word_pattern
  end

  #Gets the letter count based on the size of the word and modifies the dashes on the screen underneath the Hangman graphic.
  def get_letter_count(word_pattern,guessed_letter)
    letter_count=0
    letters = word_pattern.scan /\w/
    letters.each do |current_letter|
      if current_letter!='-'
        letter_count = letter_count+1
      end
    end
    return letter_count
  end
end
