class SessionsController < ApplicationController

    def new

    end

    def create
        @user = User.find_by(email: params[:session][:email]) 
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id 
            # binding.pry
           redirect_to user_recipes_path(@user)
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

   
end
