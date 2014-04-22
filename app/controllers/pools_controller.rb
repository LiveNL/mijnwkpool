class PoolsController < ApplicationController
  def index
    @pools = Pool.all
  end

  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new(pool_params)
     if @pool.save
        @pool.poolmemberships.create(user: current_user, role: 1)
        render 'confirmation'
    else
      render 'new'
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
