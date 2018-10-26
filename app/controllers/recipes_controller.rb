class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
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
        @recipe = Recipe.new(user_id: params[:user_id])
        2.times do 
            quantity = @recipe.quantities.build
            quantity.build_ingredient       
        end
    end
    

    def create

        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            2.times { @recipe.ingredients.build }
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
        params.require(:recipe).permit(:name, :user_id, :time, :instructions, quantities_attributes: [:amount, ingredient_attributes: [:name]])
    end

    # {"name"=>"Grilled Cheese", 
    # "quantities_attributes"=>
    # {"0"=>{
    #     "amount"=>"2", 
    #     "ingredients"=>{"name"=>"bread"}},
    #  "1"=>{"amount"=>"1", "ingredients"=>{"name"=>"cheese"}}}

end
