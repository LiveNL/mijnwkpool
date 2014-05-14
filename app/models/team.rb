class Team < ActiveRecord::Base
  has_many :gameteams
  has_many :games, through: :gameteams
  
  has_attached_file :avatar,
                  styles: {
                    medium: '500x500>',
                    small: '265x265>',
                    thumb: '100x100#'
                  },
                  default_url: 'pool/:style/missing.png'

p "Henk"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
