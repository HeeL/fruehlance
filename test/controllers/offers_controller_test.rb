require 'test_helper'

class OffersControllerTest < ActionController::TestCase

  context "index" do
    should "get index" do
      get :index
      assert_response :success
    end
  end

  context "search" do
    should "get search" do
      get :search
      assert_response :success
    end
  end

end
