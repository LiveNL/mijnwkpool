class User < ActiveRecord::Base
	has_secure_password validations: false
	
  	has_many :poolmemberships
  	has_many :pools, through: :poolmemberships
end
