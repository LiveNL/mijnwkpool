class User < ActiveRecord::Base
	attr_accessible :name, :nickname, :email, :password, :password_confirmation
	has_many :poolmembership
	has_many :pools, :through => :poolmembership
end
