require 'rails_helper'

describe 'Usuário busca status de entrega' do
  it 'informando o código de rastreamento da entrega e encontra uma OS' do

    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                    receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                    order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 50, status: :finished)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 50, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
    

    visit root_url
    fill_in 'Código de rastreamento', with: service_order.order_code
    click_on 'Buscar'

    expect(page).to have_content "Resultado da busca por: #{service_order.order_code}"
    expect(page).to have_content 'Endereço do remetente: Av. 4 de Janeiro, 244'
    expect(page).to have_content 'Endereço do destinatário: Rua 27 de Março, 877'

  end

  it 'e não encontra resultado' do
    
    visit root_url
    fill_in 'Código de rastreamento', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content "Resultado da busca por: ABC"
    expect(page).to have_content 'Nenhum resultado encontrado'

  end
end