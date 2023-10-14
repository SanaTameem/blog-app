class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    user_id = params[:user_id]
    User.find_by(id: user_id)
  end
end
