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

  test "should search in posts name, content and title" do
    assert_nothing_raised { Post.search("normal") }
    assert result = Post.search("normal"), "should return any results"
    assert_equal 1, result.size
    assert result = Post.search("normal post-count_5"), "should return any results"
    assert result = Post.search("https://www.test.at"), "should return any results"
    assert_equal 1, result.size
    assert result = Post.search("mit beschreibung"), "should return any results"
    assert_equal 3, result.size
  end
  
end
