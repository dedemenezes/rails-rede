require 'rails_helper'

RSpec.describe Observatory, type: :model do
  describe 'Associations' do
    it { should have_many(:observatory_categories).dependent(:destroy)}
    it { should have_many(:observatory_priorities).dependent(:destroy)}
    it { should have_many(:observatory_conflicts).dependent(:destroy)}
  end
end
