require 'rails_helper'

feature 'User find recipe by name' do
    scenario 'find name exact' do
    #Arrange
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    Recipe.create(title: 'Bolo de abobora', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Caiçara',
                  cook_time: 50, ingredients: 'Farinha, açucar, abobora',
                  cook_method: 'Cozinhe a abobora, corte em pedaços pequenos, misture com o restante dos ingredientes')


    #Act
    visit root_path
    fill_in "Buscar pelo nome da receita", with: "Bolo de abobora"
    click_on 'Buscar'

    #Assert
    expect(page).to have_css('h1', text: 'Bolo de abobora')
    expect(page).to have_css('h3', text: 'Sobremesa')
    expect(page).not_to have_css('h1', text: 'Bolo de cenoura')
    
    end

    scenario 'not find recipe by name exact' do
        #Act
        visit root_path
        fill_in "Buscar pelo nome da receita", with: "Bolo de Batata"
        click_on 'Buscar'

        #Assert
        expect(page).to have_css('h3', text: 'Foram encontrados 0 resultados conforme a busca')
    end

    scenario 'find multiple results by partial name' do
        #Arrange
        recipe_type = RecipeType.create(name: 'Sobremesa')
        Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: 'Brasileira',
                      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        Recipe.create(title: 'Bolo de abobora', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: 'Caiçara',
                      cook_time: 50, ingredients: 'Farinha, açucar, abobora',
                      cook_method: 'Cozinhe a abobora, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        Recipe.create(title: 'Torta de abacate', difficulty: 'Médio',
                      recipe_type: recipe_type, cuisine: 'Estranha',
                      cook_time: 50, ingredients: 'Farinha, açucar, abacate',
                      cook_method: 'Cozinhe o abacate, corte em pedaços pequenos, misture com o restante dos ingredientes')

    
        #Act
        visit root_path
        fill_in "Buscar pelo nome da receita", with: "Bolo"
        click_on 'Buscar'
    
        #Assert
        expect(page).to have_css('h3', text: 'Foram encontrados 2 resultados conforme a busca')
        expect(page).to have_css('h1', text: 'Bolo de cenoura')
        expect(page).to have_css('h1', text: 'Bolo de abobora')
        expect(page).not_to have_css('h1', text: 'Torta de abacate')
        end

end