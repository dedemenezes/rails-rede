require 'rails_helper'

RSpec.describe UnityType, type: :model do
  describe "Association" do
    it { should have_many(:observatories) }
  end
end
