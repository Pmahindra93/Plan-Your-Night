require 'test_helper'

class VenuesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get venues_index_url
    assert_response :success
  end

  # test "the truth" do
  #   assert true
  # end
end
