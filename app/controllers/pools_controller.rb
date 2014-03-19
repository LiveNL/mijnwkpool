class PoolsController < ApplicationController
  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new(pool_params) 
    if @pool.save
      @pool.poolmemberships.create(:user => current_user, :role => 1)
      redirect_to :controller => 'pools', :action => "index"
      else 
    render "new"
    end 
  end

  private
    def pool_params
      params.require(:pool).permit(:name, :image, :public, :password, :password_confirmation)
    end
end
