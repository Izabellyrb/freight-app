require 'rails_helper'

describe 'Usuário cadastra novo veículo' do
  it 'somente se estiver autenticado como usuário admin' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
  
    login_as(user)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'Cadastrar novo veículo'

    expect(current_url).to eq vehicles_url
    expect(page).to have_content 'Você não pode executar esta função.'
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    
    login_as(admin)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'Cadastrar novo veículo'
    fill_in 'Placa', with: 'ARG8P87'
    fill_in 'Marca', with: 'Yamaha'
    fill_in 'Modelo', with: 'YBR'
    fill_in 'Ano', with: '2013'
    fill_in 'Capacidade máx de carga', with: '80'
    click_on 'Salvar'

		expect(current_url).to eq(vehicles_url)
    expect(page).to have_content 'Novo veículo cadastrado com sucesso!'
    expect(page).to have_content 'ARG8P87'
  end

  it 'com dados incompletos' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)

    login_as(admin)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'Cadastrar novo veículo'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Ano', with: ''
    click_on 'Salvar'

    expect(page).to have_content "Veículo não cadastrado!"
    expect(page).to have_content "Placa de identificação não pode ficar em branco"
    expect(page).to have_content "Marca não pode ficar em branco"
    expect(page).to have_content "Ano não pode ficar em branco"
  end
end