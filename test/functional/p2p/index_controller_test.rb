require 'test_helper'

class P2p::IndexControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
