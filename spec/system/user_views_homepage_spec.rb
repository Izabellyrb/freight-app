require 'rails_helper'

describe 'usuario visita tela inicial' do
  it 'e não precisa estar autenticado' do
    #Arrange

    #Act
    visit root_url
  
    #Assert
    expect(current_url).to eq(root_url)
    expect(page).to have_content('Fretes & Entregas')
  end

  it 'e vê campo de busca para consultar status de entregas' do
    # Arrange

    # Act
    visit root_url

    # Assert
    expect(page).to have_field('Código de rastreamento')
    expect(page).to have_button('Buscar')
  end
end