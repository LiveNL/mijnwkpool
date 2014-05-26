
  def destroy
    @pool = Pool.find(params[:id])
    @poolmembership = Poolmembership.find_by_pool_id(@pool)
    @poolmembership.destroy
    @pool.destroy
    flash[:success] = 'Pool verwijderd.'
    redirect_to pools_path    
  end		


  def destroy
    @pool = Pool.find(params[:id])
    @poolmembership = Poolmembership.where(pool_id: @pool.id).all
    @poolmembership.destroy
    @pool.destroy
    flash[:success] = 'Pool verwijderd.'
    redirect_to pools_path    
  end