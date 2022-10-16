require 'rails_helper'

describe 'Usuário cadastra ordens de serviço' do
  it 'somente se estiver autenticado como usuário admin' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
  
    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on 'Cadastrar nova OS'

    expect(current_url).to eq service_orders_url
    expect(page).to have_content 'Você não pode executar esta função'

  end

  it 'com sucesso' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ISLW5723549SC9A')

    login_as(admin)
    visit root_url
    click_on 'Ordens de serviço'
    click_on 'Cadastrar nova OS'
    fill_in 'Endereço do remetente', with: 'Endereço X'
    fill_in 'Nome do remetente', with: 'Lojas X'
    fill_in 'Endereço do destinatário', with: 'Endereço'
    fill_in 'Nome do destinatário', with: 'Nome Y'
    fill_in 'Código do produto', with: 'AUIW682'
    fill_in 'Peso total', with: '54'
    fill_in 'Distância total', with: '100'
    click_on 'Salvar'

		expect(current_url).to eq service_orders_url
    expect(page).to have_content 'Nova OS cadastrada com sucesso!'
    expect(page).to have_content 'ISLW5723549SC9A'
  end

  it 'com dados incompletos' do 
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    
    login_as(admin)
    visit root_url
    click_on 'Ordens de serviço'
    click_on 'Cadastrar nova OS'
    fill_in 'Nome do remetente', with: ''
    fill_in 'Código do produto', with: ''
    click_on 'Salvar'

    expect(page).not_to have_content 'Nova OS cadastrada com sucesso!'
    expect(page).to have_content "OS não cadastrada!"
    expect(page).to have_content "Nome do remetente não pode ficar em branco"
    expect(page).to have_content "Código do produto não pode ficar em branco"
  end
end