require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    user = User.create!(email: 'admin@admin.com', password: '123456')    
    recipe_type = RecipeType.create(name: 'Sobremesa')
    pending_recipe = Recipe.create(status: :pending, user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    approved_recipe = Recipe.create(status: :approved, user: user, title: 'Bolo de churros', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to_not have_css('h1', text: pending_recipe.title)
    expect(page).to have_css('h1', text: approved_recipe.title)
    expect(page).to have_css('li', text: approved_recipe.recipe_type.name)
    expect(page).to have_css('li', text: approved_recipe.cuisine)
    expect(page).to have_css('li', text: approved_recipe.difficulty)
    expect(page).to have_css('li', text: "#{approved_recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = User.create!(email: 'admin@admin.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    approved_recipe = Recipe.create(status: :approved, user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    pending_recipe = Recipe.create(status: :pending, user: user, title: 'Feijoada',
                                   recipe_type: another_recipe_type,
                                   cuisine: 'Japonesa', difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão, carnes, algas e arroz',
                                   cook_method: 'Misture o sushi com as carnes')

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: approved_recipe.title)
    expect(page).to have_css('li', text: approved_recipe.recipe_type.name)
    expect(page).to have_css('li', text: approved_recipe.cuisine)
    expect(page).to have_css('li', text: approved_recipe.difficulty)
    expect(page).to have_css('li', text: "#{approved_recipe.cook_time} minutos")

    expect(page).not_to have_css('h1', text: pending_recipe.title)
    expect(page).not_to have_css('li', text: pending_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: pending_recipe.cuisine)
    expect(page).not_to have_css('li', text: pending_recipe.difficulty)
    expect(page).not_to have_css('li', text: "#{pending_recipe.cook_time} minutos")
  end
end


# expect(page).not_to have_link 'Aprovar receita' 
# pending_recipe.reload
# expect(pending_recipe).to be_approved