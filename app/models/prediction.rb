class Prediction < ActiveRecord::Base
  belongs_to :game
  belongs_to :poolmembership
  validates_uniqueness_of :poolmembership_id, scope: [:game_id]
  before_save :default_values

  def default_values
    self.prediction1 ||= 0
    self.prediction2 ||= 0
  end
end
