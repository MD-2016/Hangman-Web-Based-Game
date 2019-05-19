class AddWordsGroupToGames < ActiveRecord::Migration
  def change
    add_column :games, :words_group, :text
  end
end
