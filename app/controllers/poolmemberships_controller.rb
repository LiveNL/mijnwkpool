class PoolmembershipsController < ApplicationController
	def new
	end

	def create
		pool_id = params[:pool_id]
		poolmembership = Poolmembership.new(user: second_user, pool_id: pool_id, role: 0)
		poolmembership.save
		redirect_to '/pools'
	end
end
