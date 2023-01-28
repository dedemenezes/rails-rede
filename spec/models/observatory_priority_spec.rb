require 'rails_helper'

RSpec.describe ObservatoryPriority, type: :model do
  describe "Association" do
    it { should belong_to(:observatory) }
    it { should belong_to(:priority_type) }
  end
end
