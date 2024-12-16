require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'response is success' do
      get :index
      # assert_match "Acervo (Materiais)", @response.body
      # expect(response).to include('Acervo (Materiais)')
      expect(response).to have_http_status(200)
    end
    it 'should render appropriate header' do
      get :index
      # expect(response).to render_template(:index)
      expect(response.body).to match(/Acervo.+(Materiais)/)
    end
  end
end
