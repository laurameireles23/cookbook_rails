require 'rails_helper'

feature 'Admin register recipe type' do
  scenario 'successfully' do
    #Arrange

    #Act
    visit root_path
    click_on 'Cadastrar receita'
    fill_in "Nome", with: "Sobremesa"
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Sobremesa')  
  end

  scenario 'and must be unique' do
    RecipeType.create!(name: 'Sobremesa')

    visit root_path
    click_on 'Cadastrar receita'
    fill_in "Nome",	with: "Sobremesa" 
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único') 
    expect(RecipeType.count).to eq 1
  end

  scenario 'and approve recipes' do
    user = User.create!(email: 'visit@visit.com', password: '123456', role: :user)
    admin = User.create!(email: 'admin@admin.com', password: '123456', role: :admin)
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(status: :pending, user: user, title: 'Tapioca apimentada', difficulty: 'Dificil',
                           recipe_type: recipe_type, cuisine: 'Baiana',
                           cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
                           cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva')
    
    visit root_path
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'
    
    click_on 'Receitas a serem avaliadas'
    within "#recipe-#{recipe.id}" do
      click_on 'Aprovar'
    end

    expect(page).to have_content('Receita aprovada com sucesso') 
    recipes.reload
    expect(page).not_to have_content('Tapioca apimentada') 

  end
end