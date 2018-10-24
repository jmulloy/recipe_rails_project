class UsersController < ApplicationController

    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end

    def show 
        @user = User.find_by(id: params[:id])
        if @user.save
            redirect_to user_path(@user)\
        else
            render :new
        end
    end 
end
