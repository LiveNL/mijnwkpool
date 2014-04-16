class PoolsController < ApplicationController

  respond_to :json, :html

  def index 
    @pools = Pool.all
    respond_with(@pools = Pool.all)
  end

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

  def show
    @pool = Pool.find(params[:id])

  end

  def update
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :image, :is_public, :password,
                                 :password_confirmation, :avatar)
  end
end
