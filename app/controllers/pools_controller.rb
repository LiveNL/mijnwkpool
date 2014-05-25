class PoolsController < ApplicationController
  require 'will_paginate/array' 
  skip_before_filter :ensure_user, :only => [:show]

  def index

      openpool = params[:openpool] # "value1"
      case openpool
        when '0'
          @pools = Pool.all
          if params[:playerssearch1]
            @pools = Pool.where("maximum_membership >= ? AND maximum_membership <= ?", params[:playerssearch1], params[:playerssearch2])
          end
        when '1'
          @pools = Pool.find_by_sql ["select * from pools where 
          (maximum_membership >= ? AND maximum_membership <= ?) AND (is_public == ?)", params[:playerssearch1], params[:playerssearch2], true]
        when '2'
          @pools = Pool.find_by_sql ["select * from pools where 
          (maximum_membership >= ? AND maximum_membership <= ?) AND (is_public == ?)", params[:playerssearch1], params[:playerssearch2], false]
        else
          @pools = Pool.all
      end
      poolspace = params[:poolspace] # "value1"
      case poolspace 
        when '1'
        when '2'
          @pools = Pool.find_by_sql ["select * from pools p where 
            (maximum_membership >= ? AND maximum_membership <= ?) AND 
            p.maximum_membership > (select count(*) from poolmemberships pm where pm.pool_id = p.id )", 
            params[:playerssearch1], params[:playerssearch2]]  
        else
      end
      if !params[:search].nil?
        @pools = Pool.search(params[:search])
      end
  end

  def new
    @pool = Pool.new
  end

  def edit
    @pool = Pool.find(params[:id])
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

  def show
    @pool = Pool.find(params[:id])
  end

  def update
  @pool = Pool.find(params[:id])
  if @pool.update_attributes(pool_params)
    redirect_to pools_path
    flash[:success] = "Succes! '#{@pool.name}' is aangepast!"
  else
    render 'edit'
  end
  end 

  def invite
    @pool = Pool.find(params[:id])
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :image, :is_public, :password,
                                 :password_confirmation,
                                 :maximum_membership, :avatar, :score1, :prediction1)

  end
end
