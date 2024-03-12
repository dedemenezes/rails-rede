require 'rails_helper'

RSpec.describe "Galleries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/galleries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/galleries/show"
      expect(response).to have_http_status(:success)
    end
  end
end
