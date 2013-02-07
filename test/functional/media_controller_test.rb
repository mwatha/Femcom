require 'test_helper'

class MediaControllerTest < ActionController::TestCase
  test "should get videos" do
    get :videos
    assert_response :success
  end

end
