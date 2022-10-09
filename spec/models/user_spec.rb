require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'falso quando o nome estiver vazio' do
      user = User.new(name: '', email: 'camila@sistemadefrete.com.br', password: 'password')

      result = user.valid?

      expect(result).to eq false
    end
  end

  describe '#format' do
    it 'falso quando o formato de email não for válido' do
      user = User.new(name: 'Camila Souza', email: 'camila@gmail.com', password: 'password')

      result = user.valid?

      expect(result).to eq false
    end
  end
end
