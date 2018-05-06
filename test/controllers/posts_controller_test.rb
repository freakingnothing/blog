require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @post = posts(:one)
  end

  teardown do
    Rails.cache.clear
  end
  
  test "should get index" do
    get '/'
    assert_response :success
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

end
