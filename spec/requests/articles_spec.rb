require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /show" do
    it "returns http success" do
      article = create(:article)
      get article_path(article)
      expect(response).to have_http_status(:success)
    end
  end
end
