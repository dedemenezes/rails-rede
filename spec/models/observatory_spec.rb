require 'rails_helper'

RSpec.describe Observatory, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'Associations' do
    it { should have_one(:observatory_conflict).dependent(:destroy) }
  end

  describe '#create_tag' do
    context 'when creating an Observatory'
    it 'creates a Tag using Observatory name' do
      expect(Tag.count).to eq(0)
      observatory = create(:observatory)
      expect(Tag.count).to eq(1)
      expect(Tag.last.name).to eq(observatory.class.model_name)
    end
  end

  describe '#set_address' do
    context 'concatanates all address fields like number, city, state' do
      it 'returns what ' do
        ninho = create(:ninho_do_urubu)
        expect(ninho.address).to eq("#{ninho.street}, #{ninho.state}")
        ninho.street = ''
        ninho.valid?
        expect(ninho.address).to eq(ninho.state.to_s)
      end
    end
    context 'with street' do
      it 'concatanates all address fields in the correct way' do
        street = 'Rua Marques de Olinda'
        number = 80
        city = 'Rio de Janeiro'
        ninho = Observatory.new(street:)
        ninho.valid?
        expect(ninho.address).to eq(street)
        ninho.city = city
        ninho.valid?
        expect(ninho.address).to eq("#{street}, #{city}")
        ninho.number = number
        ninho.valid?
        expect(ninho.address).to eq("#{street}, #{number}, #{city}")
      end
    end
  end
end
