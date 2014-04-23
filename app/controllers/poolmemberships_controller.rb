class PoolmembershipsController < ApplicationController
  def new
  end

  def create
    pool_id = params[:pool_id]
    password = params[:password]
    pool = Pool.find(pool_id)

    if pool.poolmemberships.count == pool.maximum_membership
      flash[:error] = 'Deze pool zit vol.'
      redirect_to '/pools'
    else
      if password && pool.authenticate(password) && !pool.is_public?
        poolmembership = Poolmembership.new(user: current_user, pool_id: pool_id, role: 0)
        if poolmembership.save
          redirect_to pools_path
          flash[:success] = "Succes! Je bent aangesloten bij '#{pool.name}'!"
        else
          flash[:error] = 'Je kunt niet twee keer dezelfde pool joinen of in meer dan 3 pools tegelijk meespelen'
          redirect_to '/pools'
        end
      elsif pool.is_public?
        poolmembership = Poolmembership.new(user: current_user, pool_id: pool_id, role: 0)
        if poolmembership.save
          redirect_to pools_path
          flash[:success] = "Succes! Je bent aangesloten bij '#{pool.name}'!"
        else
          flash[:error] = 'Je kunt niet twee keer dezelfde pool joinen of in meer dan 3 pools tegelijk meespelen'
          redirect_to '/pools'
        end
      else
        flash[:error] = 'Je hebt geen toestemming om je bij deze pool aan te sluiten'
        redirect_to '/pools'
      end
    end
  end
end
