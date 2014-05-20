class Prediction < ActiveRecord::Base
  belongs_to :game
	belongs_to :poolmembership
end
