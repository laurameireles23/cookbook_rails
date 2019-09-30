class RecipesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update] 
  before_action :set_recipe, only: [:show, :edit, :update]

  def index
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
  end

  def show; end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    # @recipe = Recipe.new(recipe_params)
    # @recipe.user = current_user
    if @recipe.save 
      redirect_to @recipe
    else
      set_recipe_type
      render :new
    end
  end

  def edit
    @recipe_types = RecipeType.all
  end

  def update  
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else 
      set_recipe_type
      render :edit
    end
    
  end

  def search
    @recipes = Recipe.where('title LIKE ?', "%#{params[:search]}%")
  end
  

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end

  def set_recipe_type
    @recipe_types = RecipeType.all
  end
  

end