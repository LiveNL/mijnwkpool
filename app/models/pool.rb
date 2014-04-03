class Pool < ActiveRecord::Base
  has_secure_password validations: false
  has_many :poolmemberships
  has_many :users, through: :poolmemberships

  # Name
  validates_length_of :name,in: 3..35, message: '* De pool naam moet tussen 3-35 karakters hebben.'
  validates :name, uniqueness: { message: '* Deze pool naam is al bezet.' }
  validates_format_of :name, with: /\A(([a-zA-Z0-9]+[-_]{0,1})+)\z/, message: 'Het is niet toegestaan meerdere \'-_\' achter elkaar te plaatsen.'

  # Password
  validates :password,
            if: :private_pool?,
            presence: false,
            allow_blank: false,
            length: {
              minimum: 5,
              message: '* Het wachtwoord moet minimaal 5 karakters!'
            }

  validates_confirmation_of :password,
                            if: :private_pool?,
                            presence: false,
                            allow_blank: false,
                            message: '* De wachtwoorden komen niet overeen!'

  # Avatar
  has_attached_file :avatar,
                    styles: {
                      medium: '500x500>',
                      small: '265x265#',
                      thumb: '100x100#'
                    },
                    default_url: '/images/pool/:style/missing.png'

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
    self.password = ''
    self.password_confirmation = ''
  end

  def check_file_size
    valid?
    errors[:avatar_file_size].blank?
  end
end
