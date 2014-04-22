class PoolmembershipsController < ApplicationController
  def new
  end

  def create
    pool_id = params[:pool_id]
    password = params[:password]
    pool = Pool.find(pool_id)

    if password && pool.authenticate(password) && !pool.is_public?
      poolmembership = Poolmembership.new(user: current_user, pool_id: pool_id, role: 0)
      poolmembership.save
      redirect_to pools_path
    elsif pool.is_public?
      poolmembership = Poolmembership.new(user: current_user, pool_id: pool_id, role: 0)
      poolmembership.save
      redirect_to pools_path
    else
      flash[:error] = 'Je hebt geen toestemming om je bij deze pool aan te sluiten'
      redirect_to :back
    end
  end
end
