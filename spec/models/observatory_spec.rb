require 'rails_helper'

RSpec.describe Observatory, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:phone_number)}
    it { should validate_presence_of(:type)}
    it { should validate_inclusion_of(:type).in_array(['observatory', 'platform', 'fpso'])}
  end

  describe 'Associations' do
    it { should have_many(:observatory_categories).dependent(:destroy)}
    it { should have_many(:observatory_priorities).dependent(:destroy)}
    it { should have_many(:observatory_conflicts).dependent(:destroy)}
  end
end
