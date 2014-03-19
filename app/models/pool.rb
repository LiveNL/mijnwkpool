class Pool < ActiveRecord::Base
	has_many :poolmemberships
	has_many :users, :through => :poolmemberships

	validates_confirmation_of :password, if: :private_pool?
 	validates_length_of :password, :in => 7..15, if: :private_pool?

	def private_pool?
		public == false
	end
end