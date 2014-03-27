class Pool < ActiveRecord::Base
	has_many :poolmemberships
	has_many :users, :through => :poolmemberships
	before_save :encrypt_password

	validates_length_of :name, :in => 3..35, message: "* De pool naam moet tussen 3-35 karakters hebben."
	validates :name, uniqueness: { message: "* Deze pool naam is al bezet." }
	validates_format_of :name, with: /\w+([- ]{,1})/i

	validates_confirmation_of :password, if: :private_pool?, message: "* De wachtwoorden komen niet overeen!"
 	validates_length_of :password, :in => 5..50, if: :private_pool?, message: "* Het wachtwoord moet minimaal 5 karakters!"
 	validates_length_of :password_confirmation, :in => 5..50, if: :private_pool?, message: "* De wachtwoorden komen niet overeen!"

	def private_pool?
		public == false
	end

	def encrypt_password
	    if password.present?
	      self.password_salt = BCrypt::Engine.generate_salt
	      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	    end
  	end

end