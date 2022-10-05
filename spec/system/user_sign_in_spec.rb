require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    admin_user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password')

    visit root_url
    click_on 'Acessar área de colaboradores'
    fill_in 'E-mail', with: 'camila.souza@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    expect(page).to have_content 'Olá, Camila Souza!'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'e faz logout com sucesso' do
    admin_user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password')

    visit root_url
    click_on 'Acessar área de colaboradores'
    fill_in 'E-mail', with: 'camila.souza@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Olá, Camila Souza!'
  end
end