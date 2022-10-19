require 'rails_helper'

RSpec.describe EndServiceOrder, type: :model do
  describe '#valid?' do
    it 'falso quando o motivo de atraso estiver vazio' do
      service_order = ServiceOrder.new(sender_address: 'Av. da Folhas, 244', sender_name: 'Lojas X', receiver_address: 'Rua 27 de Março, 877', receiver_name: 'João da Silva', product_code: 'L4JG0', product_width: 6, product_height: 19, order_weight: 100, order_distance: 50, status: :progress)
      end_service_order = EndServiceOrder.new(reason: '')

      expect(end_service_order.valid?).to eq false
    end
  end
end
