require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando placa estiver vazia' do
        vehicle = Vehicle.new(plate: '', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)

        expect(vehicle.valid?).to eq false
      end
      it 'falso quando marca estiver vazia' do
        vehicle = Vehicle.new(plate: 'AFR0K23', make: '', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)

        expect(vehicle.valid?).to eq false
      end
      it 'falso quando modelo estiver vazio' do
        vehicle = Vehicle.new(plate: 'AFR0K23', make: 'Fiat', model: '', year: 2007, max_load_capacity: 500, status: :available)

        expect(vehicle.valid?).to eq false
      end
      it 'falso quando ano estiver vazio' do
        vehicle = Vehicle.new(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: '', max_load_capacity: 500, status: :available)

        expect(vehicle.valid?).to eq false
      end
      it 'falso quando capacidade estiver vazia' do
        vehicle = Vehicle.new(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: '', status: :available)

        expect(vehicle.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'falso quando a placa já estiver em uso' do
        first_vehicle = Vehicle.create!(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)
        second_vehicle = Vehicle.new(plate: 'AFR0K23', make: 'Qualquer', model: 'Aquele', year: 2000, max_load_capacity: 100, status: :available)

        expect(second_vehicle.valid?).to eq false
      end
    end

    context 'format' do
      it 'falso quando a placa não seguir o formato padrão Mercosul (LLLNLNN)' do
        vehicle = Vehicle.new(plate: 'AFR0000', make: 'Fiat', model: 'Fiorino', year: 2007, max_load_capacity: 500, status: :available)

        expect(vehicle.valid?).to eq false
      end
    end

    context 'length' do
      it 'falso quando ano não tiver 4 digitos' do
        vehicle = Vehicle.new(plate: 'AFR0K23', make: 'Fiat', model: 'Fiorino', year: 10, max_load_capacity: 500, status: :available)

        expect(vehicle.valid?).to eq false
      end
    end
  end
end
