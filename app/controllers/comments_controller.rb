class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
  end

  def create
    authorize
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @post
    else
      redirect_to '/'
    end
  end

  def show

  end

  private
  def comment_params
    params.require(:comment).permit(:comment_text)
  end

end