class PoolsController < ApplicationController
  require 'will_paginate/array'
  skip_before_filter :ensure_user, :only => [:show]

  def index
      @openpool = params[:openpool] || 0
      @poolspace = params[:poolspace] || 1
      @poolsearch = params[:search]
      @playerssearch1 = params[:playerssearch1] || 5
      @playerssearch2 = params[:playerssearch2] || 65
      case @openpool
        when '0'
          @pools = Pool.all
          if params[:playerssearch1]
            @pools = Pool.where("maximum_membership >= ? AND maximum_membership <= ?", @playerssearch1, @playerssearch2)
          end
        when '1'
          @pools = Pool.find_by_sql ["select * from pools where
          (maximum_membership >= ? AND maximum_membership <= ?) AND (is_public == ?)", @playerssearch1, @playerssearch2, true]
        when '2'
          @pools = Pool.find_by_sql ["select * from pools where
          (maximum_membership >= ? AND maximum_membership <= ?) AND (is_public == ?)", @playerssearch1, @playerssearch2, false]
        else
          @pools = Pool.all
      end

      case @poolspace
        when '1'
        when '2'
          @pools = Pool.find_by_sql ["select * from pools p where
            (maximum_membership >= ? AND maximum_membership <= ?) AND
            p.maximum_membership > (select count(*) from poolmemberships pm where pm.pool_id = p.id )",
            params[:playerssearch1], params[:playerssearch2]]
        else
      end
      if !@poolsearch.nil?
        @pools = Pool.search(params[:search])
      end
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
