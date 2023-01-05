require 'rails_helper'

RSpec.describe ObservatoryCategory, type: :model do
  describe "Association" do
    it { should belong_to(:observatory)}
    it { should belong_to(:category)}
  end
end
