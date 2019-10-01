require 'rails_helper'

describe 'User logged in to create recipe' do
    it 'post to recipe route' do 
        recipe_type = RecipeType.create!(name: 'Sobremesa')

        post recipes_path, params: { recipe: { title: 'Bolo de cenoura', 
            cousine: 'Brasileira', difficulty: 'Fácil', cook_time: 90,
            ingredients: 'Bolo de cenoura cru', recipe_type_id: recipe_type.id,
            cook_method: 'Colocar tudo numa forma'
            }}

        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:found)
    end

    it 'path to recipe route' do 
        patch recipe_path(1), params:{}
        
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(:found)
    end

end