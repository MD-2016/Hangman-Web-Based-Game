class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :difficulty
      t.string :words

      t.timestamps null: false
    end
  end
end
