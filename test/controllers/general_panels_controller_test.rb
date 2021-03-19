require 'test_helper'

class GeneralPanelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get general_panels_new_url
    assert_response :success
  end

  test "should get create" do
    get general_panels_create_url
    assert_response :success
  end

  test "should get index" do
    get general_panels_index_url
    assert_response :success
  end

end
