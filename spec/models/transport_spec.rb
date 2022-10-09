require 'rails_helper'

RSpec.describe Transport, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando o nome estiver vazio' do
        regular_transport = Transport.new(name: '', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4)

        expect(regular_transport.valid?).to eq false
      end
      it 'falso quando a distancia mín estiver vazia' do
        regular_transport = Transport.new(name: 'Comum', min_distance: '', max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4)

        expect(regular_transport.valid?).to eq false
      end
      it 'falso quando a distancia max estiver vazia' do
        regular_transport = Transport.new(name: 'Comum', min_distance: 0, max_distance: '', min_weight: 0, max_weight: 1000, fee: 4)

        expect(regular_transport.valid?).to eq false
      end
      it 'falso quando o peso mín estiver vazio' do
        regular_transport = Transport.new(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: '', max_weight: 1000, fee: 4)
        
        expect(regular_transport.valid?).to eq false
      end
      it 'falso quando o peso max estiver vazio' do
        regular_transport = Transport.new(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: '', fee: 4)

        expect(regular_transport.valid?).to eq false
      end
      it 'falso quando a taxa fixa estiver vazia' do
        regular_transport = Transport.new(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: '')

        expect(regular_transport.valid?).to eq false
      end
    end
    context 'uniqueness' do
      it 'falso quando o nome já estiver em uso' do
        first_regular_transport = Transport.create(name: 'Comum', min_distance: 0, max_distance: 800, min_weight: 0, max_weight: 1000, fee: 4)
        second_regular_transport = Transport.create(name: 'Comum', min_distance: 1, max_distance: 950, min_weight: 1, max_weight: 100, fee: 10)
        expect(second_regular_transport.valid?).to eq false
      end
    end
  end
end
