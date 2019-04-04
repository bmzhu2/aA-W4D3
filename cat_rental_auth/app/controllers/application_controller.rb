class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    
    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!(current_user)
    end

    def logout!
        session[:session_token] = nil
        if current_user
            current_user.reset_session_token!
        end
        @current_user = nil
    end

    def require_logged_out
        redirect_to cats_url if logged_in?
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_owns_cat
        unless current_user && current_user.cats.find_by(id:params[:id])
          redirect_to cats_url
        end
    end

end
