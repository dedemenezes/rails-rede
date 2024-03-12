require 'rails_helper'

RSpec.describe "Albums", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/albums/show"
      expect(response).to have_http_status(:success)
    end
  end
end
