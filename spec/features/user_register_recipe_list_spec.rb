require 'rails_helper'

feature 'User register recipe list' do
    scenario 'successfully' do
    user = User.create(email: 'admin@admin.com', password: '123456')

    visit root_path
    click_on 'Fazer Login'
    fill_in "E-mail", with: "admin@admin.com"
    fill_in "Senha", with: "123456"
    click_on 'Logar'

    click_on 'Criar nova lista'

    fill_in "Nome", with: "Natal"
    click_on 'Criar lista'

    expect(page).to have_css('h1', text: 'Minhas listas de receitas')
    expect(page).to have_css('h2', text: 'Natal')
    end

    scenario 'Logged user view yours lists' do
        user = User.create(email: 'admin@admin.com', password: '123456')
        List.create(user: user, name: 'Natal')
        List.create(user: user, name: 'Ação de graças')
 

        visit root_path
        click_on 'Fazer Login'
        fill_in "E-mail", with: "admin@admin.com"
        fill_in "Senha", with: "123456"
        click_on 'Logar'

        click_on 'Minhas listas'

        expect(page).to have_css('h1', text: 'Minhas listas de receitas')
        expect(page).to have_css('h2', text: 'Natal')
        expect(page).to have_css('h2', text: 'Ação de graças')
    end

    scenario 'with unique name' do
        user = User.create!(email: 'admin@admin.com', password: '123456')
        list = List.create!(user: user, name: 'Natal')
        visit root_path
        click_on 'Fazer Login'
        fill_in "E-mail", with: "admin@admin.com"
        fill_in "Senha", with: "123456"
        click_on 'Logar'

        click_on 'Minhas listas'
        click_on 'Criar nova lista'

        fill_in "Nome", with: "Natal"
        click_on 'Criar lista'

        
        expect(page).to have_content('Já existe uma lista com esse nome')
    end
end
        