class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]

    def new
        render :new
    end

    def create 
        user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

        # debugger

        if user
            login!(user)
            redirect_to cats_url
        else
            redirect_to new_session_url
        end  
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
