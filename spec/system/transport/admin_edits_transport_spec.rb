require 'rails_helper'

describe 'Usuário edita modalidade de transporte' do
  it 'somente se estiver autenticado como usuário admin' do
    user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)  
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
  
    login_as(user)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Editar'

    expect(current_url).to eq transports_url
    expect(page).to have_content 'Você não pode executar esta função'
  end
  it 'a partir da página da modalidade, com sucesso' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Editar'
    fill_in 'Nome', with: 'Comum plus'
    fill_in 'Distancia mínima', with: '10'
    fill_in 'Distancia máxima', with: '210'
    fill_in 'Peso mínimo', with: '1'
    fill_in 'Peso máximo', with: '900'
    fill_in 'Taxa fixa', with: '2'
    click_on 'Salvar'

    expect(current_url).to eq transport_url(regular_transport.id)
    expect(page).to have_content 'Modalidade atualizada com sucesso!'
    expect(page).to have_content 'Comum plus'
  end

  it 'e mantém os campos obrigatórios' do 
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Distancia mínima', with: ''
    fill_in 'Peso mínimo', with: ''
    fill_in 'Taxa fixa', with: ''
    click_on 'Salvar'

    expect(page).to have_content "Modalidade não atualizada!"
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Distancia mínima não pode ficar em branco"
    expect(page).to have_content "Peso mínimo não pode ficar em branco"
    expect(page).to have_content "Taxa fixa de entrega não pode ficar em branco"
  end
 end