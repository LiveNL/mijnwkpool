class PoolsController < ApplicationController
  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new(pool_params)
    if @pool.save
      render 'confirmation'
    else
      render 'new'
    end
  end

  def update
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :image, :is_public, :password, :password_confirmation, :avatar)
  end
end
