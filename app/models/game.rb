class Game < ActiveRecord::Base
  has_many :teams
  has_many :predictions
end
