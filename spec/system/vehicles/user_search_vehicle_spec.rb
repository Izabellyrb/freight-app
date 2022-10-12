require 'rails_helper'

describe 'Usuário busca veículo cadastrado através da placa de identificação' do
  it 'somente se estiver autenticado como usuário regular ou admin' do

    visit root_url
    click_on 'Gestão de frota'

    expect(current_url).to eq(new_user_session_url)
  end

  it 'e encontra um veículo' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
    first_vehicle= Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
    second_vehicle = Vehicle.create!(plate: 'EGR8J41', make: 'Renault', model: 'Master', year: 2010, max_load_capacity: 1000, status: :operating)
    third_vehicle = Vehicle.create!(plate: 'PLA3S85', make: 'Scania', model: 'P410', year: 2004, max_load_capacity: 3000, status: :maintenance)

    login_as(user)
    visit root_url
    click_on 'Gestão de frota'
    fill_in 'Busca de veículos', with: first_vehicle.plate
    click_on 'Buscar'

    expect(page).to have_content "Resultado da busca por: 'AFR0K23'"
    expect(page).to have_content '1 veículo encontrado'
    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'Disponível'
  end

  it 'e encontra múltiplos veículos' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
    first_vehicle= Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
    second_vehicle = Vehicle.create!(plate: 'EGR8J41', make: 'Renault', model: 'Master', year: 2010, max_load_capacity: 1000, status: :operating)
    third_vehicle = Vehicle.create!(plate: 'PLA3S85', make: 'Scania', model: 'P410', year: 2004, max_load_capacity: 3000, status: :maintenance)

    login_as(user)
    visit root_url
    click_on 'Gestão de frota'
    fill_in 'Busca de veículos', with: 'A'
    click_on 'Buscar'

    expect(page).to have_content '2 veículos encontrados'
    expect(page).to have_content 'AFR0K23'
    expect(page).to have_content 'PLA3S85'
    expect(page).to have_content 'Fiorino'
    expect(page).to have_content 'P410'

  end
end
