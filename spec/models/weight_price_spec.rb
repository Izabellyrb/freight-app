require 'rails_helper'

RSpec.describe WeightPrice, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando peso minimo estiver vazio' do
        weight_price = WeightPrice.new(min_weight: '', max_weight: 100, value_km: 0.50)        

        expect(weight_price.valid?).to eq false
      end
      it 'falso quando peso máximo estiver vazio' do
        weight_price = WeightPrice.new(min_weight: 0, max_weight: '', value_km: 0.50)        

        expect(weight_price.valid?).to eq false
      end
      it 'falso quando valor por km estiver vazio' do
        weight_price = WeightPrice.new(min_weight: 0, max_weight: 100, value_km: '')        

        expect(weight_price.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'falso quando o peso min já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        weight_price = WeightPrice.create!(min_weight: 0, max_weight: 100, value_km: 0.50, transport: regular_transport)
        weight_price2 = WeightPrice.new(min_weight: 0, max_weight: 150, value_km: 0.70, transport: regular_transport)

        expect(weight_price2.valid?).to eq false
      end
      it 'falso quando o peso max já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        weight_price = WeightPrice.create!(min_weight: 0, max_weight: 100, value_km: 0.50, transport: regular_transport)
        weight_price2 = WeightPrice.new(min_weight: 10, max_weight: 100, value_km: 0.70, transport: regular_transport)

        expect(weight_price2.valid?).to eq false
      end
    end
  end
end

