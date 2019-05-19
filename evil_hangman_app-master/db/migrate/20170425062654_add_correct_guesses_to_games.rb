class AddCorrectGuessesToGames < ActiveRecord::Migration
  def change
    add_column :games, :correct_guesses, :string
  end
end
