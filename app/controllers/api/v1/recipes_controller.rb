class Api::V1::RecipesController < ActionController::API
  def index
    render json: Recipe.where(params.permit(:status))
    # return render json: Recipe.all unless params[:status] && permited_status
    # render json: Recipe.try(params[:status].to_sym)
  end

  def show
    @recipe = Recipe.find_by(params[:id])
    return render json: @recipe if @recipe.present?

    render json: { message: 'Receita não encontrada' }, status: :not_found

    begin #try
      
    rescue #catch
      
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      render json: {status: 'SUCCESS'}
    else
      render json: {status: 'ERROR'}
    end
  end

  private

  def recipe_params
    params.permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end


  def permited_status
    Recipe.statuses.include?(params[:status])
  end

end