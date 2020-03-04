require 'test_helper'

class NightsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get nights_new_url
    assert_response :success
  end

  test "should get create" do
    get nights_create_url
    assert_response :success
  end

end
