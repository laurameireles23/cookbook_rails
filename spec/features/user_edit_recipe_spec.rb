require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = User.create!(email: 'admin@admin.com', password: '123456')
    list = List.create(user: user, name: 'Ação de graças')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Recipe.create(status: :approved, user: user, title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'
    
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'admin@admin.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(status: :approved, user:user, title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'
    
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'and user signed in not see edit recipe button' do
    user1 = User.create(email: 'admin@admin.com', password: '123456')
    user2 = User.create(email: 'admin2@admin.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(status: :approved, user: user1, recipe_type: recipe_type, title: 'Torta de banana', ingredients: 'Trigo, açucar, banana e canela', cook_method: 'Misture os ingredientes e ponha para assar', cook_time: 60, difficulty: 'Médio', cuisine: 'Brasileira')

    visit root_path
    
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin2@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'

    click_on 'Torta de banana'
    
    expect(page).not_to have_link('Editar')
  end

  scenario 'of other user unsuccessfully' do
      # arrange
      user1 = User.create!(email: 'admin@admin.com', password: '123456')
      user2 = User.create!(email: 'admin2@admin.com', password: '123456')
      recipe_type = RecipeType.create!(name: 'Sobremesa')
  
      recipe = Recipe.create!(user: user1, recipe_type: recipe_type, title: 'Torta de banana', ingredients: 'Trigo, açucar, banana e canela', cook_method: 'Misture os ingredientes e ponha para assar', cook_time: 60, difficulty: 'Médio', cuisine: 'Brasileira')
  
      # Act

      visit root_path

      click_on 'Fazer Login'
      fill_in "E-mail", with: "admin2@admin.com"
      fill_in "Senha", with: "123456"
      click_on 'Logar'
      
      visit edit_recipe_path(recipe)


      # Assert
      expect(current_path).to eq(root_path)

  end

  scenario 'Visitor can not see recipe edit button ' do
    # arrange
    user1 = User.create!(email: 'admin@admin.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    recipe = Recipe.create!(user: user1, recipe_type: recipe_type, title: 'Bolo de sardinha', ingredients: 'Trigo, açucar, banana e canela', cook_method: 'Misture os ingredientes e ponha para assar', cook_time: 60, difficulty: 'Médio', cuisine: 'Brasileira')
    # Act

    visit recipe_path(recipe)

    # Assert
    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Apagar')


  end
end
