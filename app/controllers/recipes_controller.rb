class RecipesController < ApplicationController

    before_action :require_login
    
    def require_login
        redirect_to root_path unless session.include? :user_id
    end
    
    def index
        if params[:user_id] && current_user.id == params[:user_id].to_i
            @user = current_user
            @recipes = @user.recipes
        elsif params[:user_id]
            flash[:alert] = "You are not authorized to view this User's Recipes"
            redirect_to recipes_path
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
            @user = current_user
            @recipe = Recipe.new(user_id: params[:user_id])
                5.times do 
                    quantity = @recipe.quantities.build
                    quantity.build_ingredient       
            end
        else
            flash[:alert] = "You are not authorized to create a recipe with your account!"
            redirect_to recipes_path
        end
            
    end
    

    def create
        @user = User.find_by(id: params[:user_id])
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
        if params[:user_id] && current_user.id == params[:user_id].to_i
            @user = current_user
            @recipe = @user.recipes.find_by(id: params[:id])
            if !@recipe
                flash[:alert] = "This recipe doesnt exist in your collection!"
                redirect_to user_recipe_path(@user)
            else
                render :edit
            end
        else
            flash[:alert] = "You are not authorized to edit this recipe!"
            redirect_to recipes_path
        end
    end

    def update
        @user = current_user 
        @recipe = Recipe.find_by(id: params[:id])
       if @recipe.update(recipe_params)
        redirect_to recipe_path(@recipe)
       else
        render :edit
       end
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