class SessionsController < ApplicationController

    def new

    end

    def create
        render :new
    end

    def login
        redirect_to user_recipes_path

    end
end
