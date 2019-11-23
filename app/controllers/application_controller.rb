class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in? ,:authenticate_user
	def current_user
      @current_user ||= User.find_by_id(session[:user])
    end

    def logged_in?
       current_user != nil
    end

    def authenticated_user
    	redirect_to login_path unless current_user.present?
    end

    def un_authenticated
    	redirect_to root_path if current_user.present?
    end
end
