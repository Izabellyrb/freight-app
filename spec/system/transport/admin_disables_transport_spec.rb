require 'rails_helper'

describe 'Usuário informa troca status da modalidade' do
  it 'somente se estiver autenticado como usuário admin' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    
    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Desabilitar'

    expect(current_url).to eq transports_url
    expect(page).to have_content 'Você não pode executar esta função'
  end

  it 'para desabilitada' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
  
    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Desabilitar'

    expect(current_url).to eq transport_url(regular_transport.id)
    expect(page).to have_content 'Desabilitada'
    expect(page).not_to have_button 'Desabilitar'
    expect(page).to have_button 'Habilitar'
  end
  it 'para habilitada' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :disabled)
  
    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Habilitar'

    expect(current_url).to eq transport_url(regular_transport.id)
    expect(page).to have_content 'Habilitada'
    expect(page).not_to have_button 'Habilitar'
    expect(page).to have_button 'Desabilitar'
  end
end
