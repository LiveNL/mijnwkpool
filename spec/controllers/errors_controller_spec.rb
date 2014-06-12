require 'spec_helper'

describe ErrorsController do

  describe "GET '500'" do
    it "returns http success" do
      get '500'
      response.should be_success
    end
  end

end
