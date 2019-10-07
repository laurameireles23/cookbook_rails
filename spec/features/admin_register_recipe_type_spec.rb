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
end