class PoolmembershipsController < ApplicationController
  before_filter :ensure_admin, :only => [:ranking]

  def new
  end

  def create
    pool_id = params[:pool_id]
    password = params[:password]
    pool = Pool.find(pool_id)

    if pool.poolmemberships.count == pool.maximum_membership
      flash[:error] = 'Deze pool zit vol.'
      redirect_to pool_path(pool)
    else
      if password && pool.authenticate(password) && !pool.is_public?
        poolmembership = Poolmembership.new(user: current_user, pool_id: pool_id, role: 0)
        if poolmembership.save
          redirect_to pool_path(pool)
          flash[:success] = "Succes! Je bent aangesloten bij '#{pool.name}'."
        else
          flash[:error] = 'Je kunt niet twee keer dezelfde pool joinen of in meer dan 3 pools tegelijk meespelen.'
          redirect_to pool_path(pool)
        end
      elsif pool.is_public?
        poolmembership = Poolmembership.new(user: current_user, pool_id: pool_id, role: 0)
        if poolmembership.save
          redirect_to pool_path(pool)
          flash[:success] = "Succes! Je bent aangesloten bij '#{pool.name}'."
        else
          flash[:error] = 'Je kunt niet twee keer dezelfde pool joinen of in meer dan 3 pools tegelijk meespelen.'
          redirect_to pool_path(pool)
        end
      else
        flash[:error] = 'Je hebt geen toestemming om je bij deze pool aan te sluiten.'
        redirect_to pool_path(pool)

      end
    end
  end

  def destroy
    @poolmembership = Poolmembership.find(params[:id])
    @poolmembership.destroy
    redirect_to app_root_path
  end

  def ranking
    @rankings = Poolmembership.ranking(100)
  end
end
