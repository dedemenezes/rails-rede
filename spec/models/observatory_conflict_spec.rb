require 'rails_helper'

RSpec.describe ObservatoryConflict, type: :model do
  describe "Association" do
    it { should belong_to(:observatory) }
    it { should belong_to(:conflict_type) }
  end
end
