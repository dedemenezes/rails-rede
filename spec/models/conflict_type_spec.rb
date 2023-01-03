require 'rails_helper'

RSpec.describe ConflictType, type: :model do
  describe 'Validation' do
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5) }
  end
end
