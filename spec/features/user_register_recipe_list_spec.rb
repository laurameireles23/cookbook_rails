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
end
        