class Pool < ActiveRecord::Base
  has_secure_password validations: false
  has_many :poolmemberships
  has_many :users, through: :poolmemberships

  before_save :clear_passwords, if: :public_pool?

  # Memberships (image breaker)
  validates_inclusion_of :maximum_membership, :in => 5..65
  validate :value_is_multiple_of_five

  # Name
  validates :name,
            length: {
              minimum: 3,
              maximum: 35,
              message: '* De pool naam moet tussen 3-35 karakters hebben.'
            },
            uniqueness: {
              message: '* Deze pool naam is al bezet.'
            },
            format: {
              with: /\A(([a-zA-Z0-9]+[-_'\s]{0,1})+)\z/,
              message: 'Het is niet toegestaan meerdere spaties, "-", "_" of "\" achter elkaar te
                        plaatsen.'
            }

  # Password
  validates :password,
            if: :private_pool?,
            presence: false,
            allow_blank: false,
            length: {
              minimum: 5,
              message: '* Het wachtwoord moet minimaal 5 karakters!'
            },
            confirmation: {
              message: '* De wachtwoorden komen niet overeen!'
            }

  # Avatar
  has_attached_file :avatar,
                    styles: {
                      medium: '500x500>',
                      small: '265x265>',
                      thumb: '100x100#'
                    },
                    default_url: 'pool/:style/missing.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  before_post_process :check_file_size

  # Methods
  def public_pool?
    is_public == true
  end

  def private_pool?
    is_public == false
  end

  def clear_passwords
    self.password_digest = ''
  end

  def check_file_size
    valid?
    errors[:avatar_file_size].blank?
  end

  def value_is_multiple_of_five
    unless maximum_membership % 5 == 0
      errors.add(:maximum_membership, 'must be multiple of 5')
    end
  end

  def search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name like ?", "%#{query}%")
  end
end