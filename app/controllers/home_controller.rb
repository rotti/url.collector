class HomeController < ApplicationController
  def index
    @posts = Post.all
    #last created posts
    @last_posts = Post.find(:all, :order => "id desc", :limit => 6)
    #value posts are defined with a description. sql: one character (_) followed by zero, one, or more characters (%)
    #if no post has a description we just take all posts
    @value_posts =  Post.where( 'content like ?', '_%' )
    if @value_posts.empty? 
      @value_posts = Post.all
    end  
    #random post from the value posts
    @featured_post = @value_posts.sort_by { rand }.first
   
    #create a hash of all Tags with their count of posts: "tag_id" => tag.post_id.count
    #XXX there must be a better way. there are too many areas inside and stuff and ...
    @tag_postcount = Hash[*[Tag.includes(:posts).all.map {
      |tag| [tag.id, tag.posts.all.map {
        |post| post.id
      }.count]
    }.flatten].sort_by { |tagname,postcount| }.flatten]
  end
end
