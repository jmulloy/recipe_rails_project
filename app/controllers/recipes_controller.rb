class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def destroy
        recipe = Recipe.find(params[:id])
        recipe.destroy
        redirect_to recipes_path, notice: "deleted Recipe #{recipe.name}"
    end

    def new
        @recipe = Recipe.new
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
        params.require(:recipe).permit(:name, :ingredients)
    end

end
