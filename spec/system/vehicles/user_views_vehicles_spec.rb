require 'rails_helper'

describe 'Usuário vê os veículos cadastrados' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
      visit root_url
      click_on 'Gestão de frota'
  
      expect(current_url).to eq(new_user_session_url)
  end
  it 'com sucesso' do
    user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456')
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)

    login_as(user)
    visit root_url
    click_on 'Gestão de frota'

    expect(page).to have_content 'Veículos cadastrados'
    expect(page).to have_content 'Placa'
    expect(page).to have_content 'Modelo'
    expect(page).to have_content 'Capacidade máx de carga'
    expect(page).to have_content 'Situação atual'
    expect(page).to have_content 'AFR0K23'
    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'Disponível'
  end
  it 'em detalhes' do
    user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456')
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)

    login_as(user)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'AFR0K23'

    expect(page).to have_content 'Detalhes do veículo'
    expect(page).to have_content 'Marca'
    expect(page).to have_content 'Ano'
    expect(page).to have_content 'Fiat'
    expect(page).to have_content '2007'
  end
  it 'e volta para pagina de gestão de frota' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
    
    login_as(user)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'AFR0K23'
    click_on 'Voltar'

    expect(current_url).to eq(vehicles_url)
    expect(page).to have_content('Gestão de frota')
  end
end
