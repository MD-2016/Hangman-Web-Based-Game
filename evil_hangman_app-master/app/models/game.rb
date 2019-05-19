class Game < ActiveRecord::Base
  belongs_to :user


  validates :name, presence: true
  serialize :words_group,Array

end
