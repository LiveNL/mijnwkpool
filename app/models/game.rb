class Game < ActiveRecord::Base
  has_many :gameteams
  has_many :teams, through: :gameteams
end
