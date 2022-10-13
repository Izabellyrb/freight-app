require 'rails_helper'

describe 'Usuário vê as modalidades de transporte' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
      visit root_url
      click_on 'Modalidades de transporte'
      
      expect(current_url).to eq(new_user_session_url)
  end

  it 'cadastradas na app' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    light_transport = Transport.create!(name: 'Leve', min_distance: 0, max_distance: 50, min_weight: 0, max_weight: 80, fee: 1, status: :enabled)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    heavy_transport = Transport.create!(name: 'Pesado', min_distance: 101, max_distance: 200, min_weight: 201, max_weight: 1000, fee: 10, status: :enabled)

    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'

    expect(page).to have_content 'Modalidades de transporte'
    expect(page).to have_content 'Comum'
    expect(page).to have_content 'Leve'
    expect(page).to have_content 'Pesado'
  end

  it 'e volta para página inicial' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    
    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Voltar'

    expect(current_url).to eq(root_url)
    expect(page).to have_content('Fretes & Entregas')
  end
end