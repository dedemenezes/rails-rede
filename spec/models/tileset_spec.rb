require 'rails_helper'

RSpec.describe Tileset, type: :model do
  describe 'Callbacks' do
    context 'Before validations' do
      it 'strips name from any trailing space' do
        tileset = build(:tileset, name: " \n Tileset Test  \n")
        tileset.valid?
        expect(tileset.name).to eq('Tileset Test')
      end
    end
  end

  describe '#replace_non_ascii_with_ascii' do
    it 'replaces non ascii character for ascii characters' do
      tileset = Tileset.new
      actual = tileset.replace_non_ascii_with_ascii('A visão quiÇÁ está inútil')
      expect(actual).to eq('A visao quiCA esta inutil')
    end
  end
end
