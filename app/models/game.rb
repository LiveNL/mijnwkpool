class Game < ActiveRecord::Base
  has_many :predictions
  has_many :teams
end 