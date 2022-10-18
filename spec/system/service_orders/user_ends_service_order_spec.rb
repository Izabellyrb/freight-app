require 'rails_helper'

describe 'Usuário encerra ordens de serviço' do
  it 'a partir da pagina de detalhes da OS' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barro@sistemadefrete.com.br', password: '7891011', function: :regular_user) 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                        receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                                        order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 50, status: :progress)

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

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on service_order.order_code

    expect(page).not_to have_button 'Encerrar OS'
  end

end