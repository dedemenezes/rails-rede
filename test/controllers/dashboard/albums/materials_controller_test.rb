require "test_helper"

class Dashboard::Albums::MaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:coppola)
  end
  test 'GET index' do
    # doc_album = albums(:published_with_one_document)
    # video_album = albums(:published_with_one_video)
    get dashboard_materials_url
    assert_response :success
  end
end
