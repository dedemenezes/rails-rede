require 'rails_helper'

RSpec.describe "Dashboard::PriorityTypes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/dashboard/priority_types/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/dashboard/priority_types/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/dashboard/priority_types/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
