require 'rails_helper'

describe 'Recipes Types Api' do
  context 'create' do
    it 'creates recipe type' do

      post '/api/v1/recipe_types', params: {name: 'Brunch'}
      
      json_recipes_type = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
      expect(RecipeType.last.name).to eq 'Brunch'

    end
  end
end