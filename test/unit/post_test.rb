require 'test_helper'

class PostTest < ActiveSupport::TestCase
  #just a normal entry to posts
  test "should create a new post with name, title and content" do
    assert p = Post.new
    assert_equal false, p.valid?, "should not be valid; Post.new seems to be broken"
    p.name = "new test post"
    p.title = "http://new.post.fu"
    p.content = "some text that emulates our description"
    assert_equal true, p.valid?, "all fields of the post should be valid"
    assert_nothing_raised {p.save!}
  end 
end
