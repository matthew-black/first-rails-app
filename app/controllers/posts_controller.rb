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
    only_for_matt
    @post = Post.new
  end

  # POST /posts
  def create
    only_for_matt
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      @errors = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    only_for_matt
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
    only_for_matt
    @post = Post.find(params[:id])
  end

  def update
    only_for_matt
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :content))
      redirect_to @post
    else
      render 'edit'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

end