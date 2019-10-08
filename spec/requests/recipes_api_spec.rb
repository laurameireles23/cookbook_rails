require 'rails_helper'

describe 'Recipes Api' do
    context 'index' do
        it 'and view multiple recipes' do
            user = User.create!(email: 'visit@visit.com', password: '123456', role: :user)
            recipe_type = RecipeType.create(name: 'Entrada')
            recipe = Recipe.create(status: :pending, user: user, title: 'Tapioca apimentada', difficulty: 'Dificil',
            recipe_type: recipe_type, cuisine: 'Baiana',
            cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
            cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva')
            other_recipe = Recipe.create(status: :pending, user: user, title: 'Tapioca de maniçoba', difficulty: 'Dificil',
            recipe_type: recipe_type, cuisine: 'Baiana',
            cook_time: 50, ingredients: 'Farinha de tapioca, maniçoba',
            cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de soco e sirva')

            get '/api/v1/recipes'

            json_recipes = JSON.parse(response.body, symbolize_names: true)

            expect(request).to have_http_status(:ok)
            expect(json_recipes[0][:title]).to eq 'Tapioca apimentada'
            expect(json_recipes[1][:title]).to eq 'Tapioca maniçoba'
        end    
    end
end