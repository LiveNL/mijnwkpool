class Pool < ActiveRecord::Base
  include BCrypt, MultiStepModel

  has_many :poolmemberships
  has_many :users, through: :poolmemberships
  before_save :clear_passwords, if: :public_pool?
  # before_save :password_validation, :encrypt_password, if: :private_pool?

  # Name
  validates_length_of :name, in: 3..35, message: '* De pool naam moet tussen 3-35 karakters hebben.'
  validates :name, uniqueness: { message: '* Deze pool naam is al bezet.' }
  validates_format_of :name, with: /\A(([a-zA-Z0-9]+[-_]{0,1})+)\z/, message: 'Het is niet toegestaan meerdere \'-_\' achter elkaar te plaatsen.'

  # Password
  validates_length_of :password, in: 5..35, if: :private_pool?, message: '* Het wachtwoord moet minimaal 5 karakters!'
  validates_confirmation_of :password, if: :private_pool?, message: '* De wachtwoorden komen niet overeen!'

  def public_pool?
    is_public == true
  end

  def private_pool?
    is_public == false
  end

  # def password_validation
  #   validates_length_of :password, in: 5..35, if: :private_pool?
  # end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def clear_passwords
    self.password = ''
    self.password_confirmation = ''
  end

  def self.total_steps
    2
  end
end
