class PoolsController < ApplicationController
  require 'will_paginate/array'
  skip_before_filter :ensure_user, :only => [:show]

  def index
      @openpool = params[:openpool] || '0'
      @poolspace = params[:poolspace] || '1'
      @poolsearch = params[:search]
      @playerssearch1 = params[:playerssearch1] || '5'
      @playerssearch2 = params[:playerssearch2] || '65'

      @pools = Pool.where(
        maximum_membership: (@playerssearch1..@playerssearch2)
      )

      if @openpool != '0'
        @pools = @pools.where(is_public: @openpool == '1' ? true : false)
      end

      if @poolspace == '2'
        @pools = @pools.where("maximum_membership > poolmemberships_count")
      end

      if !@poolsearch.nil?
        @pools = Pool.search(params[:search])
      end

      @pools = @pools.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    if current_user.poolmemberships.count == 99
      flash[:error] = 'Je zit al in 3 pools.'
      redirect_to :back
    else
      @pool = Pool.new
    end
  end

  def create
    @pool = Pool.new(pool_params)
    if current_user.poolmemberships.count == 99
      flash[:error] = 'Je zit al in 3 pools.'
      redirect_to :back
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
    @my_pool = @pool.users.where(id: current_user.id).count > 0 ? true : false
    @poolmember = @pool.poolmemberships.where(user_id: current_user.id).first
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
