class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_recipes_path(@user)
        else
            redirect_to new_user_path
        end
    end

    

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
