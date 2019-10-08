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

            expect(response).to have_http_status(:ok)
            expect(response.content_type).to eq 'application/json'
            expect(json_recipes[0][:title]).to eq 'Tapioca apimentada'
            expect(json_recipes[1][:title]).to eq 'Tapioca de maniçoba'
        end

        it 'view one recipe' do
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

            get api_v1_recipe_path(recipe)

            json_recipes = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(response.content_type).to eq 'application/json'
            expect(json_recipes[:title]).to eq 'Tapioca apimentada'
            expect(json_recipes[:title]).not_to eq 'Tapioca de maniçoba'
        end

        it 'and recipes are approved' do
            user = User.create!(email: 'visit@visit.com', password: '123456', role: :user)
            recipe_type = RecipeType.create(name: 'Entrada')
            recipe = Recipe.create(status: :approved, user: user, title: 'Tapioca apimentada', difficulty: 'Dificil',
            recipe_type: recipe_type, cuisine: 'Baiana',
            cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
            cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva')

            other_recipe = Recipe.create(status: :approved, user: user, title: 'Geleia de mocotó', difficulty: 'Dificil',
            recipe_type: recipe_type, cuisine: 'Baiana',
            cook_time: 50, ingredients: 'Farinha de tapioca, mocotó',
            cook_method: 'Hidrate o mocotó, prepare na frigideira a tapioca, cozinhe 7 horas o osso e sirva')

            pending_recipe = Recipe.create(status: :pending, user: user, title: 'Sorvete de coentro', difficulty: 'Insane',
            recipe_type: recipe_type, cuisine: 'Baiana',
            cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
            cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva')

            get '/api/v1/recipes?status=approved'
            # get api_v1_recipes_path(status: 'approved')

            json_recipes = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(response.content_type).to eq 'application/json'
            expect(json_recipes[0][:title]).to eq 'Tapioca apimentada'
            expect(json_recipes[0][:status]).to eq 'approved'
            expect(json_recipes[1][:title]).to eq 'Geleia de mocotó'
            expect(json_recipes[1][:status]).to eq 'approved'
            expect(response.body).not_to include('Sorvete de coentro')
        end
    end
end