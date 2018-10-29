class SessionsController < ApplicationController

    def new

    end

    def create



        if auth_hash = request.env["omniauth.auth"]
            @user = User.find_or_create_by_omniauth(auth_hash)
            session[:user_id] = @user.id
            redirect_to user_recipes_path(@user)
        else

            @user = User.find_by(email: params[:session][:email]) 
            if @user && @user.authenticate(params[:session][:password])
                session[:user_id] = @user.id 
                redirect_to user_recipes_path(@user)
            else
                render :new
            end
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
