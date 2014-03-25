class Pool < ActiveRecord::Base
	has_many :poolmemberships
	has_many :users, :through => :poolmemberships

	validates_presence_of :name, message: "* Het veld mag niet leeg zijn!"
	validates_length_of :name, :in => 3..35, message: "* De pool naam moet tussen 3-35 karakters hebben! "

	
	validates_confirmation_of :password, if: :private_pool?, message: "* De wachtwoorden komen niet overeen!"
 	validates_length_of :password, :in => 7..15, if: :private_pool?, message: "* Het wachtwoord moet minimaal 7 karakters!"

	def private_pool?
		public == false
	end
end