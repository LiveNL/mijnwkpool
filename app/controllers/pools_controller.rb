require 'will_paginate/array' 

class PoolsController < ApplicationController
  def index
    @pools = Pool.all
      if !params[:search].nil?
        @pools = Pool.search(params[:search])
      end

      openpool = params[:openpool] # "value1"
      case openpool
      when '0'
        flash[:notice] = 'Alle pools'
      when '1'
        @pools = Pool.where(:is_public => true)
        flash[:notice] = 'Openbare pools'
      when '2'
        @pools = Pool.where(:is_public => false)
        flash[:notice] = 'Prive pools'
      else
      end

      poolspace = params[:poolspace] # "value1"
      case poolspace 
      when '1'
        flash[:notice] = 'Tonen'
      when '2'
        @pools = Pool.verbergen
        flash[:notice] = 'Verbergen'      
      else
      end
    @pools = @pools.paginate(:page => params[:page], :per_page => 5)
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
