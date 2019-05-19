class AddDeathsToGames < ActiveRecord::Migration
  def change
    add_column :games, :deaths, :string
  end
end
