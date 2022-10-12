require 'rails_helper'

RSpec.describe DistancePrice, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando distancia mínima estiver vazia' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        distance_price = DistancePrice.new(min_distance: '', max_distance: 65, value_km: 9.00, transport: regular_transport)

        expect(distance_price.valid?).to eq false
      end
      it 'falso quando distancia máxima estiver vazia' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        distance_price = DistancePrice.new(min_distance: 51, max_distance: '', value_km: 9.00, transport: regular_transport)

        expect(distance_price.valid?).to eq false
      end
      it 'falso quando valor por km estiver vazio' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        distance_price = DistancePrice.new(min_distance: 51, max_distance: 65, value_km: '', transport: regular_transport)

        expect(distance_price.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'falso quando a distancia mínima já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        distance_price = DistancePrice.create!(min_distance: 51, max_distance: 65, value_km: 9.00, transport: regular_transport)
        distance_price1 = DistancePrice.new(min_distance: 51, max_distance: 70, value_km: 5.00, transport: regular_transport)

        expect(distance_price1.valid?).to eq false
      end
      it 'falso quando a distancia maxima já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        distance_price = DistancePrice.create!(min_distance: 51, max_distance: 65, value_km: 9.00, transport: regular_transport)
        distance_price1 = DistancePrice.new(min_distance: 61, max_distance: 65, value_km: 5.00, transport: regular_transport)

        expect(distance_price1.valid?).to eq false
      end
    end
  end
end
