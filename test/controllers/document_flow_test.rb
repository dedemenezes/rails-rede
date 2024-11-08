require "test_helper"

class DocumentFlowTest < ActionDispatch::IntegrationTest
  test 'should GET galleries/documents#index' do
    get document_flow_index_url
    assert_response :success
  end

  test 'index show published galleries containing albums with documents only' do
    gallery = galleries(:one)
    get document_flow_index_url

    assert_select 'p', with: gallery.name
    assert_select '.observatory__card', count: 1
  end

  test 'index show link to galleries/documents#show' do
    gallery = galleries(:one)
    get document_flow_index_url
    assert_select 'a', href: document_flow_url(gallery)
  end

  test 'should GET galleries/documents/:name#show' do
    gallery = galleries(:one)
    get document_flow_url(gallery)
    assert_response :success
  end
end
