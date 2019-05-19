class AddWrongGuessesToGames < ActiveRecord::Migration
  def change
    add_column :games, :wrong_guesses, :string
  end
end
