class Prediction < ActiveRecord::Base
  belongs_to :game
	belongs_to :poolmembership
  validates_uniqueness_of :poolmembership_id, scope: [:game_id]
end
