require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:header) }
    it { should validate_uniqueness_of(:header) }
  end

  describe 'Associations' do
    it { should have_one_attached(:banner) }
  end
end
