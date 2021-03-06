class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update] 
  before_action :set_recipe, only: [:show, :edit, :update, :add_to_list, :approve, :reject, :destroy]

  def index
    @recipes = Recipe.approved
    @recipe_types = RecipeType.all
  end

  def show
    @item = RecipeListItem.new
    @lists = List.all
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save 
      redirect_to @recipe
    else
      set_recipe_type
      render :new
    end
  end

  def edit
    if current_user != @recipe.user
      redirect_to root_path
    else
      @recipe_types = RecipeType.all
    end
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
  
  def add_to_list
    @list = List.find(params[:list_id])
    @item = RecipeListItem.new(list_id: params[:list_id], recipe_id: params[:id])
    @lists = List.all
    if @item.save
      redirect_to @list
      flash[:notice] = 'Receita adicionada a lista com sucesso'
    else
      render :show
      flash[:notice] = 'Essa receita já foi adicionada anteriormente'
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to root_path
      flash[:notice] = 'Receita apagada com sucesso'
    else
      flash[:notice] = 'Não foi possivel deletar sua receita'
    end
  end

  def evaluate
    if current_user.admin?
      @recipes = Recipe.pending
      @recipe_types = RecipeType.all

    else
      redirect_to root_path
    end
  end

  def approve
    @recipe.approved!
    flash[:notice] = 'Receita aprovada com sucesso'
    redirect_to evaluate_recipes_path
  end

  def reject
    @recipe.rejected!
    redirect_to evaluate_recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, :avatar)
  end

  def set_recipe_type
    @recipe_types = RecipeType.all
  end
  

end