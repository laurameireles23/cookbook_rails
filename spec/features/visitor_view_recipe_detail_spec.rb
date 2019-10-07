require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    user = User.create!(email: 'admin@admin.com', password: '123456')

    #cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    pending_recipe = Recipe.create(status: :pending, user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    approved_recipe = Recipe.create(status: :approved, user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: 'Brasileira', difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
 
    # simula a ação do usuário
    visit root_path
    click_on approved_recipe.title

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: approved_recipe.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: approved_recipe.recipe_type.name)
    expect(page).to have_css('p', text: approved_recipe.cuisine)
    expect(page).to have_css('p', text: approved_recipe.difficulty)
    expect(page).to have_css('p', text: "#{approved_recipe.cook_time} minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: approved_recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: approved_recipe.cook_method)
  end

  scenario 'and return to recipe list' do
    #cria os dados necessários
    user = User.create!(email: 'admin@admin.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(status: :approved, user:user, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
end
