class SessionsController < ApplicationController
    layout "welcome"

    skip_before_action :authorized, only: [:new, :create, :welcome]

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to companies_path
        else
            redirect_to '/login', notice: "Username or password invalid"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to '/welcome'
    end
end
