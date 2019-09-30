require 'rails_helper'

feature 'User do authentication' do
  scenario 'login successfully' do
    #Arrange
    user = User.create!(email: 'admin@admin.com', password: '123456')

    #Act
    visit root_path
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'

    #Assert
    expect(page).to have_content('Usuário logado com sucesso')  
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Fazer Login')
  end

  scenario 'logout successfully' do
    #Arrange
    user = User.create!(email: 'admin@admin.com', password: '123456')

    #Act
    visit root_path
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'
    click_on 'Logout'

    # Assert
    expect(page).to have_content('Usuário deslogado com sucesso')
    expect(page).to have_link('Criar novo usuário')
    expect(page).to have_link('Fazer Login')
    expect(page).not_to have_link('Logout')
  end

  scenario 'and register user' do

    #Act
    visit root_path
    click_on 'Criar novo usuário'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    fill_in "Confirmar senha", with: "123456"
    click_on 'Criar'

    # Assert
    expect(page).to have_content('Usuário criado e logado com sucesso')
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Fazer Login')
    expect(page).not_to have_link('Criar novo usuário')
  end
end