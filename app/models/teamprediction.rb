class Teamprediction < ActiveRecord::Base
  belongs_to :team
  belongs_to :poolmembership
end
