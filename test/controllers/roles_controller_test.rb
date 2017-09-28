require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  test "should get roles" do
    get :roles
    assert_response :success
  end

end
