class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        user_id = params[:user_id]
        current_user = User.find_by(id: user_id)
    end
end
