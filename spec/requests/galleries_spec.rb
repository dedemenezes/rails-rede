require 'rails_helper'

RSpec.describe "Galleries", type: :request do
  describe "GET /acervos/imagens" do
    it "returns http success" do
      get imagens_galleries_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /acervos/documentos" do
    it "returns http success" do
      get documentos_galleries_path
      expect(response).to have_http_status(:success)
    end
  end
end
