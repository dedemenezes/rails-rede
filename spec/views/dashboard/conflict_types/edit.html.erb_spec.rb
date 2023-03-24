require 'rails_helper'

RSpec.describe "dashboard/conflict_types/edit", type: :view do
  let(:dashboard_conflict_type) {
    Dashboard::ConflictType.create!()
  }

  before(:each) do
    assign(:dashboard_conflict_type, dashboard_conflict_type)
  end

  it "renders the edit dashboard_conflict_type form" do
    render

    assert_select "form[action=?][method=?]", dashboard_conflict_type_path(dashboard_conflict_type), "post" do
    end
  end
end
