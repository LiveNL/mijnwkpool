class PoolsController < ApplicationController
  def create
  	@pool = Pool.new(pool_params)	
  	if @pool.save
  		@pool.poolmemberships.create(:user => current_user)
  	end	
  end

  private
    def pool_params
      params.require(:pool).permit(:name)
    end
end
