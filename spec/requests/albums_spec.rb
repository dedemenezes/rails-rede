require 'rails_helper'

RSpec.describe "Albums", type: :request do
  describe "GET /show" do
    it "returns http success" do
      album = create(:published_event_album)
      get album_path(album)
      expect(response).to have_http_status(:success)
    end
  end
end
