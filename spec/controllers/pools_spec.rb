require "spec_helper"

describe PoolsController do
	describe "Post create" do
	  it "must have a current_user to create a pool" do
	  	pool = Pool.create
	  	post 'create', :pool => { :name => 'current_user'}
	  end
	end
end


# describe MenuItemsController, "creating a new menu item" do
#   integrate_views
#   fixtures :menu_items
  
#   it "should redirect to index with a notice on successful save" do
#     MenuItem.any_instance.stubs(:valid?).returns(true)
#     post 'create'
#     assigns[:menu_item].should_not be_new_record
#     flash[:notice].should_not be_nil
#     response.should redirect_to(menu_items_path)
#   end

#   it "should re-render new template on failed save" do
#     MenuItem.any_instance.stubs(:valid?).returns(false)
#     post 'create'
#     assigns[:menu_item].should be_new_record
#     flash[:notice].should be_nil
#     response.should render_template('new')
#   end
  
#   it "should pass params to menu item" do
#     post 'create', :menu_item => { :name => 'Plain' }
#     assigns[:menu_item].name.should == 'Plain'
#   end
# end