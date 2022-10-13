require 'rails_helper'

describe 'Usuário edita veículo cadastrado' do
  it 'somente se estiver autenticado como usuário admin' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :maintenance)
  
    login_as(user)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'AFR0K23'
    click_on 'Editar'

    expect(current_url).to eq vehicles_url
    expect(page).to have_content 'Você não pode executar esta função.'
  end
  it 'a partir da página de detalhes do veículo, com sucesso' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)  
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :maintenance)
  
    login_as(admin)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'AFR0K23'
    click_on 'Editar'
    fill_in 'Placa', with: 'AFR5A22'
    fill_in 'Marca', with: 'Volkswagen'
    click_on 'Salvar'

    expect(current_url).to eq vehicle_url(vehicle.id)
    expect(page).to have_content 'Veículo atualizado com sucesso!'
    expect(page).to have_content 'AFR5A22'
    expect(page).to have_content 'Volkswagen'
  end

  it 'e mantém os campos obrigatórios' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)

    login_as(admin)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'AFR0K23'
    click_on 'Editar'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    click_on 'Salvar'

    expect(page).to have_content "Veículo não atualizado!"
    expect(page).to have_content "Placa de identificação não pode ficar em branco"
    expect(page).to have_content "Marca não pode ficar em branco"
  end

  it 'e muda somente o status na página de detalhes' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)  
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :maintenance)
  
    login_as(admin)
    visit root_url
    click_on 'Gestão de frota'
    click_on 'AFR0K23'
    click_on 'Veículo está disponível'

    expect(current_url).to eq vehicle_url(vehicle.id)
    expect(page).to have_content 'Situação atual do veículo atualizada!'
    expect(page).to have_content 'Disponível'
  end
end