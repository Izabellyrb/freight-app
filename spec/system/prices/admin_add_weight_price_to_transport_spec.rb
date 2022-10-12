require 'rails_helper'

  describe 'Usuário cadastra novo preço a modalidade' do
    it 'somente se estiver autenticado como usuário admin' do
      user = User.create!(name: 'Fernando Barros', email: 'fernando.barros@sistemadefrete.com.br', password: '7891011', function: :regular_user)
      regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
    
      login_as(user)
      visit root_url
      click_on 'Modalidades de transporte'
      click_on 'Comum'
      click_on 'Cadastrar novo preço'

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
    click_on 'Cadastrar novo preço'
    fill_in 'Peso mínimo', with: '101'
    fill_in 'Peso máximo', with: '150'
    fill_in 'Valor por km', with: 0.90
    click_on 'Salvar'

		expect(current_url).to eq transport_url(regular_transport.id)
    expect(page).to have_content 'Novo preço cadastrado com sucesso!'
    expect(page).to have_content '101 - 150 Kg'
    expect(page).to have_content 'R$ 0,90'
  end

  it 'com dados incompletos' do 
    admin = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: '123456', function: :admin)
    regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)

    login_as(admin)
    visit root_url
    click_on 'Modalidades de transporte'
    click_on 'Comum'
    click_on 'Cadastrar novo preço'
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Valor por km', with: ''
    click_on 'Salvar'

    expect(page).not_to have_content 'Novo preço cadastrado com sucesso!'
    expect(page).to have_content "Preço não cadastrado!"
    expect(page).to have_content "Peso mínimo não pode ficar em branco"
    expect(page).to have_content "Peso máximo não pode ficar em branco"
  end
end