require 'rails_helper'

describe 'Usuário vê os preços por distância' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
    visit root_url
    click_on 'Modalidades de transporte'

  
    expect(current_url).to eq(new_user_session_url)
  end

  it 'na tela de modalidades de trasporte especifica' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    distance_price = DistancePrice.create!(min_distance: 0, max_distance: 80, value_km: 0.50, transport: regular_transport)
    
    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'

    expect(page).to have_content 'Preços por distância'
    expect(page).to have_content 'Intervalo de distância (Km)'
    expect(page).to have_content '0 - 80 Km'
    expect(page).to have_content 'R$ 0,50'
  end
end