require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando o endereço remetente estiver vazio' do
        service_order = ServiceOrder.new(sender_address: '', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: 100, order_distance: 50, status: :pending)

        expect(service_order.valid?).to eq false
      end

      it 'falso quando o nome remetente estiver vazio' do
        service_order = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: '', receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: 100, order_distance: 50, status: :pending)

        expect(service_order.valid?).to eq false
      end

      it 'falso quando o endereço destinatario estiver vazio' do
        service_order = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: '', receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: 100, order_distance: 50, status: :pending)

        expect(service_order.valid?).to eq false
      end

      it 'falso quando o nome destinatario estiver vazio' do
        service_order = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', receiver_name: '', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: 100, order_distance: 50, status: :pending)

        expect(service_order.valid?).to eq false
      end

      it 'falso quando o código produto estiver vazio' do
        service_order = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', product_code: '', product_width: 6, product_height: 19, order_weight: 100, order_distance: 50, status: :pending)

        expect(service_order.valid?).to eq false
      end

      it 'falso quando o peso total estiver vazio' do
        service_order = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: '', order_distance: 50, status: :pending)

        expect(service_order.valid?).to eq false
      end

      it 'falso quando o distancia total estiver vazia' do
        service_order = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: 100, order_distance: '', status: :pending)

        expect(service_order.valid?).to eq false
      end
    end
  end

  describe 'gerador código aleatório' do 
    it 'ao criar nova ordem de serviço' do
      user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: 'password')
      service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X',  
                      receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', 
                      product_code: 'L4JG0', product_width: 6, product_height: 19, 
                      order_weight: 100, order_distance: 50, status: :pending)

      service_order.save!
      result = service_order.order_code

      expect(result).not_to be_empty
      expect(result.length).to eq 15
    end

    it 'e o código é único' do
      user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: 'password')
      service_order1 = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X',  
                      receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', 
                      product_code: 'L4JG0', product_width: 6, product_height: 19, 
                      order_weight: 100, order_distance: 50, status: :pending)

      service_order2 = ServiceOrder.new(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X',  
                      receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', 
                      product_code: 'L4JG0', product_width: 6, product_height: 19, 
                      order_weight: 100, order_distance: 50, status: :pending)

      service_order2.save!

      expect(service_order2.order_code).not_to eq(service_order1.order_code)
    end

    it 'e não deve ser modificado' do
      user = User.create!(name: 'Camila Souza', email: 'camila.souza@sistemadefrete.com.br', password: 'password')
      service_order = ServiceOrder.create!(sender_address: 'Av. 4 de Janeiro, 244', sender_name: 'Lojas X',  
                      receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', 
                      product_code: 'L4JG0', product_width: 6, product_height: 19, 
                      order_weight: 100, order_distance: 50, status: :pending)
      original_code = service_order.order_code

      service_order.update!(product_code: 'PPPG0')

      #Assert
      expect(service_order.order_code).to eq(original_code)
    end
  end
end
