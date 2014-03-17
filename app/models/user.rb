class User < ActiveRecord::Base
	has_many :poolmemberships
	has_many :pools, :through => :poolmemberships
end
