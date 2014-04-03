class PoolsController < ApplicationController
  def new
    wizard = ModelWizard.new(Pool, session).start
    @pool = wizard.object
  end

  def create
    wizard = ModelWizard.new(Pool, session, params).process
    @pool = wizard.object
    if wizard.save
      @pool.poolmemberships.create(user: current_user, role: 1)
      redirect_to controller: 'pools', action: 'index'
    else
      render :new
    end
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :image, :is_public, :password,
                                 :password_confirmation)
  end
end
