require 'test_helper'

class QueryControllerTest < ActionController::TestCase
  test "should get buildTeam" do
    get :buildTeam
    assert_response :success
  end

end
