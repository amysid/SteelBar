require 'test_helper'

class CustomerPanelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_panels_new_url
    assert_response :success
  end

  test "should get create" do
    get customer_panels_create_url
    assert_response :success
  end

  test "should get index" do
    get customer_panels_index_url
    assert_response :success
  end

end
