class Api::V1::CommentsController < ApplicationController
  # load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:create]

  def index
    @comments = Post.includes(:comments).find(params[:post_id]).comments
    pretty_json = JSON.pretty_generate(success: true, data: { commetns: @comments.as_json })
    render json: pretty_json, status: :ok
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comments = @post.comments.new(comment_params)
    @comments.post_id = @post.id
    @comments.user_id = @user.id

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
