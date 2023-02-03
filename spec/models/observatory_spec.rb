require 'rails_helper'

RSpec.describe Observatory, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
  end

  describe 'Associations' do
    it { should have_one(:observatory_category).dependent(:destroy) }
    it { should have_one(:observatory_priority).dependent(:destroy) }
    it { should have_one(:observatory_conflict).dependent(:destroy) }
    it { should have_one(:category) }
    it { should have_one(:priority_type) }
    it { should have_one(:conflict_type) }
  end

  describe '#create_tag' do
    context 'when creating an Observatory'
    it 'creates a Tag using Observatory name' do
      expect(Tag.count).to eq(0)
      create(:observatory)
      expect(Tag.count).to eq(1)
    end
  end
end
