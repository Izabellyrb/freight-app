require 'rails_helper'

  describe 'Usuário cadastra novo preço a modalidade' do
    it 'somente se estiver autenticado como usuário admin' do
      user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)
      regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    
      login_as(user)
      visit root_url
      click_on 'Modalidades de transporte'
      click_on 'Comum'
      within ("#preços_km") do
        click_on 'Cadastrar novo preço'
      end

      expect(current_url).to eq transport_url(regular_transport.id)
      expect(page).to have_content 'Você não pode executar esta função.'

    end

  it 'com sucesso' do
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    within ("#preços_km") do
      click_on 'Cadastrar novo preço'
    end
    fill_in 'Distância mínima', with: '51'
    fill_in 'Distância máxima', with: '80'
    fill_in 'Taxa fixa', with: 9.00
    click_on 'Salvar'

		expect(current_url).to eq transport_url(regular_transport.id)
    expect(page).to have_content 'Novo preço cadastrado com sucesso!'
    expect(page).to have_content '51 - 80 Km'
    expect(page).to have_content 'R$ 9'
  end

  it 'com dados incompletos' do 
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    within ("#preços_km") do
      click_on 'Cadastrar novo preço'
    end
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Taxa fixa', with: ''
    click_on 'Salvar'

    expect(page).not_to have_content 'Novo preço cadastrado com sucesso!'
    expect(page).to have_content "Preço não cadastrado!"
    expect(page).to have_content "Distância mínima não pode ficar em branco"
    expect(page).to have_content "Distância máxima não pode ficar em branco"
  end
end