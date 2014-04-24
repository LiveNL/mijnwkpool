class PoolsController < ApplicationController
  require 'will_paginate/array' 
  skip_before_filter :ensure_user, :only => [:show]

  def index
    @pools = Pool.all
      if !params[:search].nil?
        @pools = Pool.search(params[:search])
      end

      openpool = params[:openpool] # "value1"
      case openpool
      when '0'
      when '1'
        @pools = Pool.where(:is_public => true)
      when '2'
        @pools = Pool.where(:is_public => false)
      else
      end

      poolspace = params[:poolspace] # "value1"
      case poolspace 
      when '1'
      when '2'
        @pools = Pool.verbergen
      else
      end
    # @pools = @pools.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.new(pool_params)
    if current_user.poolmemberships.count == 500
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

  def show
@pool = Pool.find(params[:id])
@pool.users
  end

  def update
  end

  def invite
    @pool = Pool.find(params[:id])
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :image, :is_public, :password,
                                 :password_confirmation,
                                 :maximum_membership, :avatar)
  end
end
