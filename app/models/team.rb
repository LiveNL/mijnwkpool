class Team < ActiveRecord::Base
  has_many :games
  
  has_attached_file :avatar,
                  styles: {
                    medium: '500x500>',
                    small: '265x265>',
                    thumb: '100x100#',
                    mini: '70x50#'
                  },
                  default_url: 'pool/:style/missing.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
