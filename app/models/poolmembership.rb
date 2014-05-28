class Poolmembership < ActiveRecord::Base
  belongs_to :pool, counter_cache: true
  belongs_to :user
  validates_uniqueness_of :user_id, scope: [:pool_id]
  has_many :predictions, dependent: :destroy

  MAXIMUM_COURSES = 5

  def self.get_user_id
    self.new.user_id
  end

  validate on: :create do
    if user.poolmemberships.size >= MAXIMUM_COURSES
      errors.add :user, "can only apply for #{MAXIMUM_COURSES} courses. Please remove one."
    end
  end
end
