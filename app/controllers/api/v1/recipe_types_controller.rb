class Api::V1::RecipeTypesController < ActionController::API
  def create
    recipe = RecipeType.new(recipe_type_params)
    if recipe.save
      render json: {status: 'SUCCESS'}
    else
      render json: {status: 'ERROR'}
    end
  end

  private

  def recipe_type_params
    params.permit(:name)
  end
end