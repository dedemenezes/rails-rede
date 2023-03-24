require 'rails_helper'

RSpec.describe "dashboard/conflict_types/index", type: :view do
  before(:each) do
    assign(:dashboard_conflict_types, [
      Dashboard::ConflictType.create!(),
      Dashboard::ConflictType.create!()
    ])
  end

  it "renders a list of dashboard/conflict_types" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
