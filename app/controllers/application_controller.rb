class ApplicationController < ActionController::Base
  before_action :get_recipes
  def get_recipes
    @recipe_types_sidebar = RecipeType.all
  end
end
