require 'rails_helper'

describe 'Usuário vê as modalidades de transporte' do
  it 'somente se estiver autenticado como usuário regular ou admin' do
  
      visit root_url
      click_on 'Modalidades de transporte'
  
      expect(current_url).to eq(new_user_session_url)
  end

  it 'cadastradas na app' do
    user = User.create!(name: 'Camila Souza', email:'camila.souza@sistemadefrete.com.br', password: 'password') 
    economic_transport = Transport.create!(name: 'Economico', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 1)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4)
    express_transport = Transport.create!(name: 'Expresso', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 10)

    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'

    expect(page).to have_content 'Modalidades de transporte'
    expect(page).to have_content 'Comum'
    expect(page).to have_content 'Economico'
    expect(page).to have_content 'Expresso'
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