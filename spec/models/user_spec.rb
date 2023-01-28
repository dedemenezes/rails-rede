require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:first_name).scoped_to(:last_name) }
  end

  describe "Association" do
    it { should have_one_attached(:avatar) }
  end

  describe '#full_name' do
    it 'returns first name and last name concatenated' do
      user = User.new(first_name: 'francis', last_name: 'coppola')
      expect(user.full_name).to eq('Francis Coppola')
      expect(create(:coppola).full_name).to eq('Francis Coppola')
    end
  end
end
