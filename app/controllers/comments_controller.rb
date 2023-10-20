class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.user_id = @user.id
    @comment.post_id = @post.id

    if @comment.save
      flash[:notice] = 'Comment was saved succesfully'
      redirect_to user_post_path(@post.author_id, @post)
    else
      render :new
    end
  end

  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.user == @user || @user.role == 'admin'
      @comment.destroy
      flash[:notice] = 'Comment successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end

    redirect_to user_post_path(@post.author_id, @post.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
