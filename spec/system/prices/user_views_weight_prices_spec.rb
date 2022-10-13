require 'rails_helper'

describe 'Usuário vê os preços por peso' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
    visit root_url
    click_on 'Modalidades de transporte'

  
    expect(current_url).to eq(new_user_session_url)
  end

  it 'na tela de modalidades de trasporte especifica' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    weight_price = WeightPrice.create!(min_weight: 0, max_weight: 10, value_km: 0.50, transport: regular_transport)
    weight_price2 = WeightPrice.create!(min_weight: 51, max_weight: 100, value_km: 0.50, transport: regular_transport)
    

    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'

    expect(page).to have_content 'Preços por peso'
    expect(page).to have_content 'Intervalo de peso (Kg)'
    expect(page).to have_content '0 - 10 Kg'
    expect(page).to have_content '51 - 100 Kg'
  end
end