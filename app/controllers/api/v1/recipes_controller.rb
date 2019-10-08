class Api::V1::RecipesController < ActionController::API
  def index 
    @recipes = Recipe.all 
    # @recipe_types = RecipeTypes.all

    render json: @recipes

    # render json: {recipes: @recipes, recipe_types: @recipe_types}.to_json
  end
end