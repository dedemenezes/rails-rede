require 'rails_helper'

RSpec.describe "dashboard/conflict_types/show", type: :view do
  before(:each) do
    assign(:dashboard_conflict_type, Dashboard::ConflictType.create!)
  end

  it "renders attributes in <p>" do
    render
  end
end
