require 'rails_helper'

describe 'Usuário vê as ordens de serviço' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
      visit root_url
      click_on 'Ordens de serviço'
      
      expect(current_url).to eq(new_user_session_url)
  end

  it 'cadastradas na app' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', 
                                          receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, 
                                          order_code: 'ISLW5723549SC9A', order_weight: 100, order_distance: 50, status: :pending)

    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'

    expect(page).to have_content 'Ordens de serviço'
    expect(page).to have_content 'Nº da OS'

  end

  it 'e volta para página inicial' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    
    login_as(user)
    visit root_url
    click_on 'Ordens de serviço'
    click_on 'Voltar'

    expect(current_url).to eq(root_url)
    expect(page).to have_content('Fretes & Entregas')
  end
end