require 'rails_helper'

feature "user view your recipes after auth" do
    scenario "view your recipes" do
        user = User.create!(email: 'admin@admin.com', password: '123456')
        recipe_type = RecipeType.create(name: 'Sobremesa')
        RecipeType.create(name: 'Entrada')
        Recipe.create(user: user, title: 'Bolo de Brócolis', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: 'Brasileira',
                      cook_time: 50, ingredients: 'Farinha, açucar, brócolis',
                      cook_method: 'Cozinhe o brócolis, corte em pedaços pequenos, misture com o restante dos ingredientes')
        Recipe.create(user: user, title: 'Torta de Cactus', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: 'Brasileira',
                      cook_time: 50, ingredients: 'Farinha, açucar, cactus',
                      cook_method: 'Descasque o cactu, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        # act
        visit root_path
        click_on 'Fazer Login'
        fill_in "E-mail", with: "admin@admin.com"
        fill_in "Senha", with: "123456"
        click_on 'Logar'
        click_on "Minhas receitas"

        expect(page).to have_content('Minhas receitas')
        expect(page).to have_content('Bolo de Brócolis')
        expect(page).to have_content('Torta de Cactus')
    end
    
end