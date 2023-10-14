class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author_id = current_user.id

    if @post.save
      flash[:notice] = 'Post was saved succesfully'
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end
end
