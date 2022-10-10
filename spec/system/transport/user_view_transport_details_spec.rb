require 'rails_helper'

describe 'Usuário vê detalhes de uma modalidade de transporte' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
      visit root_url
      click_on 'Modalidades de transporte'
  
      expect(current_url).to eq(new_user_session_url)
  end

  it 'com sucesso' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    regular_transport = Transport.create!(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4)

    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'

    expect(page).to have_content 'Transporte Comum'
    expect(page).to have_content 'Distância atendida (Km) Pesos atendidos (Kg) Taxa fixa de entrega' #view em tabela
    expect(page).to have_content '0 - 800 Km 0 - 1000 Kg R$ 4,00'
  end

  it 'e volta para página de modalidades' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    regular_transport = Transport.create!(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4)

    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Voltar'

    expect(current_url).to eq(transports_url)
    expect(page).to have_content('Fretes & Entregas')
  end
end