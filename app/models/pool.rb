class Pool < ActiveRecord::Base
	has_many :poolmemberships
	has_many :users, :through => :poolmemberships
end
