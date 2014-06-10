class Team < ActiveRecord::Base
  has_many :games
  has_many :teampredictions, :dependent => :destroy
  
  has_attached_file :avatar,
                  styles: {
                    medium: '500x500>',
                    small: '265x265>',
                    thumb: '100x100#',
                    mini: '70x50#'
                  },
                  default_url: 'pool/:style/missing.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.pouleleader(position, poule, poolmembership_id)
    Team.connection.execute """
      SELECT tp.pouleposition, t.poule, t.name, t.id, tp.poolmembership_id, t.avatar_file_name, t.avatar_content_type, t.avatar_file_size, t.avatar_updated_at
      FROM teampredictions tp
        LEFT JOIN teams t
          ON tp.team_id = t.id
      WHERE tp.pouleposition = #{position}
      AND t.poule = '#{poule}'
      AND tp.poolmembership_id = #{poolmembership_id};      
    """
  end

  def self.eightleader(game_id, final, poolmembership_id, winner)
    winner = winner == nil ? 0 : winner
    Team.connection.execute """
      SELECT p.id, p.final, p.game_id, t.id, p.poolmembership_id, t.name, p.winner, t.avatar_file_name, t.avatar_content_type, t.avatar_file_size, t.avatar_updated_at
      FROM predictions p
        LEFT JOIN teams t
          ON p.winner = t.id
      WHERE p.game_id = #{game_id}
      AND p.final = #{final}
      AND p.poolmembership_id = #{poolmembership_id}
      AND p.winner = ?;       
    """
  end  
end
