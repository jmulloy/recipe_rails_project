class RecipesController < ApplicationController

    before_action :require_login
    
    def require_login
        redirect_to root_path unless session.include? :user_id
    end
    
    def index
        binding.pry
        if params[:user_id] && current_user.id == params[:user_id].to_i
            @user = current_user
            @recipes = @user.recipes
       
        else
            @recipes = Recipe.all
        end
    end


    def name
        @recipes = Recipe.ordered_by_name
    end

    def show
        @recipe = Recipe.find_by(id: params[:id])
    end

    def destroy
        recipe = Recipe.find(params[:id])
        recipe.destroy
        redirect_to recipe_path, notice: "deleted Recipe #{recipe.name}"
    end

    
    def new
        if params[:user_id] && current_user.id == params[:user_id].to_i

        @recipe = Recipe.new(user_id: params[:user_id])
            5.times do 
                quantity = @recipe.quantities.build
                quantity.build_ingredient       
            end
        end
    end
    

    def create

        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            redirect_to user_recipe_path(current_user, @recipe)
        else
            5.times do 
                quantity = @recipe.quantities.build
                quantity.build_ingredient
            end 
            render :new
        end
    end

    def edit 
        @recipe = Recipe.find_by(id: params[:id])
    end

    def update
        @recipe = Recipe.find_by(id: params[:id])
        @recipe.update(recipe_params)
        redirect_to user_recipe_path(@recipe)
    end

    def recipe_params
        params.require(:recipe).permit(:name, :user_id, :description, :time, :instructions, quantities_attributes: [:amount, ingredient_attributes: [:name]])
    end

    # {"name"=>"Grilled Cheese", 
    # "quantities_attributes"=>
    # {"0"=>{
    #     "amount"=>"2", 
    #     "ingredients"=>{"name"=>"bread"}},
    #  "1"=>{"amount"=>"1", "ingredients"=>{"name"=>"cheese"}}}

end