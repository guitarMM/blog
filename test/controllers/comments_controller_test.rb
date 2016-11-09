require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get post:references" do
    get comments_post:references_url
    assert_response :success
  end

end
