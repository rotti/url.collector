class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  helper_method :sort_column, :sort_direction
  def index
    @per_page = params[:per_page] || Post.per_page || 5
    @posts = Post.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => @per_page, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @tags = Tag.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @tags = Tag.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @posts = Post.find(params[:id])
    @tags = Tag.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @posts = Post.new(params[:post])
    @tags = Tag.all
    @tag = Tag.new

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Entry was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @posts = Post.all
    @tags = Tag.all

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @posts = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private  
  def sort_column  
    Post.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end  
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

end
