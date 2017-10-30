class PostsController < ApplicationController

# "Controller Actions"
  # GET /posts
  def index
    @posts = Post.order(:created_at).reverse
  end

  # GET /posts/:id
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      @errors = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

end