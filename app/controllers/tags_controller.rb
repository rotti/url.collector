class TagsController < ApplicationController
  helper_method :sort_column, :sort_direction

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
      format.js # show.js.erb
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

    # Column Sorting
  private  
  def sort_column  
    Post.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end  
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

end
