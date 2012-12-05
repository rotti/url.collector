class HomeController < ApplicationController
  def index
    @last_posts = Post.find(:all, :order => "id desc", :limit => 3).reverse
  end
end
