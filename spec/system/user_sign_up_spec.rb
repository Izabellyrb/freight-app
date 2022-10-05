require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do

    visit root_url
    click_on 'Acessar área de colaboradores'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Camila Souza'
    fill_in 'E-mail', with: 'camila.souza@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Sair'
    user = User.last
    expect(user.name).to eq 'Camila Souza'
    expect(user.email).to have_content '@sistemadefrete.com.br'

  end

end