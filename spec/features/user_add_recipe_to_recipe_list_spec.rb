require 'rails_helper'

feature 'User add recipe to recipe list' do
    scenario 'successfully' do
        user = User.create(email: 'admin@admin.com', password: '123456')
        list = List.create(user: user, name: 'Ação de graças')
        recipe_type = RecipeType.create(name: 'Entrada')
        recipe = Recipe.create(user: user, title: 'Tapioca apimentada', difficulty: 'Dificil',
                      recipe_type: recipe_type, cuisine: 'Baiana',
                      cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
                      cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva')
                

        visit root_path
        click_on 'Fazer Login'
        fill_in "E-mail", with: "admin@admin.com"
        fill_in "Senha", with: "123456"
        click_on 'Logar'

        click_on 'Tapioca apimentada'
        select 'Ação de graças', from: 'Listas'
        click_on 'Adicionar a lista'

        expect(list.recipes).to include(recipe)
        expect(page).to have_content('Receita adicionada a lista com sucesso')
    end
end