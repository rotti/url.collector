class TagsController < ApplicationController

  def index
    @tags = Tag.all
    @posts = Post.all

    @tag_tokens = Tag.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tag_tokens }
    end
  end

  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.delete

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @tag = @post.tags.create(params[:tag])
    
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

end
