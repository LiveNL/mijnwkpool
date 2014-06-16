class Poolmembership < ActiveRecord::Base
  belongs_to :pool, counter_cache: true
  belongs_to :user
  validates_uniqueness_of :user_id, scope: [:pool_id]
  has_many :predictions, dependent: :destroy
  has_many :teampredictions, dependent: :destroy

  MAXIMUM_COURSES = 5

  def self.get_user_id
    self.new.user_id
  end

  def self.ranking(limit = 10)
    Poolmembership.connection.execute """
      SELECT u.nickname, p.name pool, pm.score
      FROM poolmemberships pm
      LEFT JOIN users u ON pm.user_id = u.id
      LEFT JOIN pools p ON pm.pool_id = p.id
      ORDER BY pm.score
      DESC LIMIT #{limit};
    """
  end

  validate on: :create do
    if user.poolmemberships.size >= MAXIMUM_COURSES
      errors.add :user, "can only apply for #{MAXIMUM_COURSES} courses. Please remove one."
    end
  end
end
