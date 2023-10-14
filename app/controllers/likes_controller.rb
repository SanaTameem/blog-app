class LikesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: @user.id, post_id: @post.id)
    if @like.save
      flash[:notice] = 'Like was saved succesfully'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Could not save the like'
    end
  end
end
