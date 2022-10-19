require 'rails_helper'

describe 'Usuário encerra ordens de serviço' do
  it 'a partir da pagina de detalhes da OS' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barro@sistemadefrete.com.br', password: '7891011', function: :regular_user) 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                        receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                                        order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 50, status: :progress)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 50, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    distance_price = DistancePrice.create!(min_distance: 0, max_distance: 1000, value_km: 5.00, transport: regular_transport)
    weight_price = WeightPrice.create!(min_weight: 0, max_weight: 1000, value_km: 0.60, transport: regular_transport)
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :operating)
    start_service_order = StartServiceOrder.create!(transport: regular_transport, vehicle: vehicle, service_order: service_order)

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on service_order.order_code
    click_on 'Encerrar OS'

    expect(page).to have_content 'Finalizada'

  end

  it 'Somente se status estiver em andamento' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barro@sistemadefrete.com.br', password: '7891011', function: :regular_user) 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                        receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                                        order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 50, status: :pending)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 50, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    distance_price = DistancePrice.create!(min_distance: 0, max_distance: 1000, value_km: 5.00, transport: regular_transport)
    weight_price = WeightPrice.create!(min_weight: 0, max_weight: 1000, value_km: 0.60, transport: regular_transport)
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
    start_service_order = StartServiceOrder.create!(transport: regular_transport, vehicle: vehicle, service_order: service_order)

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on service_order.order_code

    expect(page).not_to have_button 'Encerrar OS'
  end

  it 'e registra data de encerramento com ou sem atraso' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barro@sistemadefrete.com.br', password: '7891011', function: :regular_user) 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                        receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 170, product_height: 59, 
                                        order_code: 'ISLW5723549SC9A', order_weight: 700, order_distance: 150, status: :progress)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 50, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    distance_price = DistancePrice.create!(min_distance: 0, max_distance: 1000, value_km: 5.00, transport: regular_transport)
    weight_price = WeightPrice.create!(min_weight: 0, max_weight: 1000, value_km: 0.60, transport: regular_transport)
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :operating)
    start_service_order = StartServiceOrder.create!(transport: regular_transport, vehicle: vehicle, service_order: service_order)

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on service_order.order_code
    click_on 'Encerrar OS'

    expect(page).to have_content 'Status de entrega: No prazo'
  end

end