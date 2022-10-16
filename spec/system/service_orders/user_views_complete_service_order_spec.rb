require 'rails_helper'

describe 'Usuário vê a ordens de serviço' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
    visit root_url
    click_on 'Ordens de serviço'
    
    expect(current_url).to eq(new_user_session_url)
  end

  it 'a partir da pagina de detalhes da OS, somente se status estiver pendente' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user) 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                        receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                                        order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 50, status: :finished)

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on service_order.order_code

    expect(page).not_to have_content 'Escolha a modalidade:'
  end

  it 'com a modalidade de transporte escolhida' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user) 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                        receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                                        order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 60, status: :progress)

    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
    
    StartServiceOrder.create!(transport: regular_transport, service_order: service_order, vehicle: vehicle)

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on service_order.order_code

    expect(page).not_to have_content 'Escolha a modalidade:'
    expect(page).not_to have_button 'Iniciar OS'
    expect(page).to have_content 'Modalidade de transporte:'
    expect(page).to have_content 'Comum'
    expect(page).to have_content 'Placa do veículo:'
    expect(page).to have_content 'AFR0K23'
  end

end