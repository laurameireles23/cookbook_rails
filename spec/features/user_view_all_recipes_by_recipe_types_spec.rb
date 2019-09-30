require 'rails_helper'

feature 'User view all recipes by recipe types' do
    scenario 'User view recipe types and click for view all recipes by recipe type ' do
    #Arrange
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    recipe_type = RecipeType.create(name: 'Entrada')
    Recipe.create(title: 'Tapioca apimentada', difficulty: 'Dificil',
                  recipe_type: recipe_type, cuisine: 'Baiana',
                  cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
                  cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva')


    #Act
    visit root_path
    click_on 'Sobremesa'


    #Assert
    expect(page).to have_css('h3', text: 'Sobremesa')
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_css('h1', text: 'Tapioca apimentada')
    
    end

end