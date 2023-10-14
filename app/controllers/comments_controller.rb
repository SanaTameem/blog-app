class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.create(params.require(:comment).permit(:text))
    @comment.user_id = @user.id
    @comment.post_id = @post.id

    if @comment.save
      flash[:notice] = 'Comment was saved succesfully'
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end
end
