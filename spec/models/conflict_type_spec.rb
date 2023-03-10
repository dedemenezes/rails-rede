require 'rails_helper'

RSpec.describe ConflictType, type: :model do
  describe 'Validation' do
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5) }
  end

  describe 'Associations' do
    it { should have_many(:observatory_conflicts).dependent(:destroy) }
    it { should have_many(:observatories) }
  end
end
