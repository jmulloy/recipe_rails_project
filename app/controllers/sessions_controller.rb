class SessionsController < ApplicationController

    def new

    end

    def create

        if auth_hash = request.env["omniauth.auth"]
            oauth_email = request.env["omniauth.auth"]["info"]["email"]
            if user = User.find_by(:email => oauth_email)
                session[:user_id] = @user.id
            else
                User = User.new(:email => oauth_email)
                session[:user_id] = @user.id
            end

        @user = User.find_by(email: params[:session][:email]) 
        binding.pry
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id 
           redirect_to user_recipes_path(@user)
        else
            render :new
        end
    end

    def destroy
        session.clear
        redirect_to '/'
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

   
end
