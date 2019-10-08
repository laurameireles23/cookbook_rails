class Api::V1::RecipesController < ActionController::API
  def index
    render json: Recipe.where(params.permit(:status))
    # return render json: Recipe.all unless params[:status] && permited_status
    # render json: Recipe.try(params[:status].to_sym)
  end

  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe
  end

  private
  
  def permited_status
    Recipe.statuses.include?(params[:status])
  end

end