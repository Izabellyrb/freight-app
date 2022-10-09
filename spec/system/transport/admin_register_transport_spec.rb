require 'rails_helper'

describe 'Usuário cadastra nova modalidade de transporte' do
  it 'somente se estiver autenticado como usuário admin' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
  
    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Cadastrar nova modalidade'

    expect(current_url).to eq transports_url
    expect(page).to have_content 'Você não tem acesso a esta área'

  end
  it 'com sucesso' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Cadastrar nova modalidade'
    fill_in 'Nome', with: 'Super economico'
    fill_in 'Distancia mínima', with: '0'
    fill_in 'Distancia máxima', with: '200'
    fill_in 'Peso mínimo', with: '0'
    fill_in 'Peso máximo', with: '1000'
    fill_in 'Taxa fixa', with: '0'
    click_on 'Salvar'

		expect(current_url).to eq(transports_url)
    expect(page).to have_content 'Nova modalidade cadastrada com sucesso!'
    expect(page).to have_content 'Super economico'
  end

  it 'com dados incompletos' do 
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Cadastrar nova modalidade'
    fill_in 'Nome', with: ''
    fill_in 'Distancia mínima', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Taxa fixa de entrega', with: ''
    click_on 'Salvar'

    expect(page).to have_content "Modalidade não cadastrada!"
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Distancia mínima não pode ficar em branco"
    expect(page).to have_content "Peso máximo não pode ficar em branco"
    expect(page).to have_content "Taxa fixa de entrega não pode ficar em branco"
  end
end