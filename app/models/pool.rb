class Pool < ActiveRecord::Base
  include MultiStepModel

  has_secure_password validations: false
  has_many :poolmemberships
  has_many :users, through: :poolmemberships

  # Name
  validates_length_of :name, in: 3..35, message: '* De pool naam moet tussen 3-35 karakters hebben.'
  validates :name, uniqueness: { message: '* Deze pool naam is al bezet.' }
  validates_format_of :name, with: /\A(([a-zA-Z0-9]+[-_]{0,1})+)\z/, message: 'Het is niet toegestaan meerdere \'-_\' achter elkaar te plaatsen.'

  # Password
  validates :password, 
            :presence => false,   
            :allow_blank => false,
            :length => { :minimum => 5, message: '* Het wachtwoord moet minimaal 5 karakters!'}

  validates_confirmation_of :password, 
            :presence => false,   
            :allow_blank => false,
            :message => '* De wachtwoorden komen niet overeen!' 

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

  def self.total_steps
    2
  end
end
