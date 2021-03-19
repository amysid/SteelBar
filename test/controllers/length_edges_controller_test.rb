require 'test_helper'

class LengthEdgesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get length_edges_new_url
    assert_response :success
  end

  test "should get index" do
    get length_edges_index_url
    assert_response :success
  end

  test "should get show" do
    get length_edges_show_url
    assert_response :success
  end

end
