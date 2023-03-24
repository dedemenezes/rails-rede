require 'rails_helper'

RSpec.describe "dashboard/conflict_types/new", type: :view do
  before(:each) do
    assign(:dashboard_conflict_type, Dashboard::ConflictType.new())
  end

  it "renders new dashboard_conflict_type form" do
    render

    assert_select "form[action=?][method=?]", dashboard_conflict_types_path, "post" do
    end
  end
end
