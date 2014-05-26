class PoolsController < ApplicationController
  require 'will_paginate/array'
  skip_before_filter :ensure_user, :only => [:show]

  def index
<<<<<<< HEAD

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
=======
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
>>>>>>> origin/bugfixes
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
    if current_user.poolmemberships.count == 5
      flash[:error] = 'Je zit al in 5 pools.'
      redirect_to :back
    else
      @pool = Pool.new
    end
  end

  def edit
    @pool = Pool.find(params[:id])
  end

  def create
    @pool = Pool.new(pool_params)
    if current_user.poolmemberships.count == 5
      flash[:error] = 'Je zit al in 5 pools.'
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
<<<<<<< HEAD
=======
    @my_pool = @pool.users.where(id: current_user.id).count > 0 ? true : false
    @poolmember = @pool.poolmemberships.where(user_id: current_user.id).first
>>>>>>> origin/bugfixes
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
