require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it { should validate_uniqueness_of(:email) }
  end

  describe "Association" do
    it { should have_one_attached(:avatar)}
  end

  describe '#full_name' do
    it 'returns first name and last name concatenated' do
      expect(create(:coppola).full_name).to eq('Francis Coppola')
    end
  end
end
