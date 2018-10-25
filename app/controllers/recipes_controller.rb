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
        @recipe = Recipe.new
        2.times { @recipe.ingredients.build }
    end
    

    def create
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end

    def recipe_params
        params.require(:recipe).permit(:name, :instructions, :ingredients, :quantities)
    end

end
