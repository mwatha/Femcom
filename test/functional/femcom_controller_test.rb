require 'test_helper'

class FemcomControllerTest < ActionController::TestCase
  test "should get events" do
    get :events
    assert_response :success
  end

end
