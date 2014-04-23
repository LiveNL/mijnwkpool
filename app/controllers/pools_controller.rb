class PoolsController < ApplicationController
  def index
    @pools = Pool.all
  end

  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new(pool_params)
    if current_user.poolmemberships.count == 3
      flash[:error] = 'Je zit al in 3 pools.'
      redirect_to pools_path
    else
      if @pool.save
        @pool.poolmemberships.create(user: current_user, role: 1)
        render 'confirmation'
      else
        render 'new'
      end
    end
  end

  def update
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :image, :is_public, :password,
                                 :password_confirmation, :avatar,
                                 :maximum_membership)
  end
end
