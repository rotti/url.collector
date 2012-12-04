class TagsController < ApplicationController

  def index
    @tags = Tag.all
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
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
    #@posts = Posts.all
    @tag.delete

    respond_to do |format|
      format.html { redirect_to posts_url }
      #format.html { render action: "edit" }
      format.json { head :no_content }
    end
  end

end
