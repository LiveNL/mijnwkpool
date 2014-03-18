class Pool < ActiveRecord::Base
	has_many :poolmemberships
	has_many :users, :through => :poolmemberships

	validates_confirmation_of :password
  	validates_length_of :password, :in => 7..15
end