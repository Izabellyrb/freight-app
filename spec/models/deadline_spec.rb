require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando distancia mínima estiver vazia' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        deadline = Deadline.new(min_distance: '', max_distance: 50, time: 48, transport: regular_transport)

        expect(deadline.valid?).to eq false
      end
      it 'falso quando distancia máxima estiver vazia' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        deadline = Deadline.new(min_distance: 0, max_distance: '', time: 48, transport: regular_transport)

        expect(deadline.valid?).to eq false
      end
      it 'falso quando prazo estiver vazio' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        deadline = Deadline.new(min_distance: 0, max_distance: 50, time: '', transport: regular_transport)

        expect(deadline.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'falso quando a distancia mínima já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        deadline = Deadline.create!(min_distance: 0, max_distance: 50, time: 48, transport: regular_transport)
        deadline2 = Deadline.new(min_distance: 0, max_distance: 100, time: 75, transport: regular_transport)

        expect(deadline2.valid?).to eq false
      end
      it 'falso quando a distancia maxima já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        deadline = Deadline.create!(min_distance: 10, max_distance: 50, time: 48, transport: regular_transport)
        deadline2 = Deadline.new(min_distance: 0, max_distance: 50, time: 75, transport: regular_transport)

        expect(deadline2.valid?).to eq false
      end
      it 'falso quando o prazo já estiver em uso' do
        regular_transport = Transport.create!(name: 'Comum', min_distance: 51, max_distance: 100, min_weight: 81, max_weight: 200, fee: 4, status: :enabled)
        deadline = Deadline.create!(min_distance: 10, max_distance: 50, time: 48, transport: regular_transport)
        deadline2 = Deadline.new(min_distance: 0, max_distance: 30, time: 48, transport: regular_transport)

        expect(deadline2.valid?).to eq false
      end
    end
  end
end
