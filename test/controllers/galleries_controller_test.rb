require "test_helper"

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery = galleries(:one)
  end

  test "show includes OG metadata for public access" do
    get gallery_path(@gallery, t: 'documentos')
    assert_response :success

    assert_select "meta[property='og:title'][content='#{@gallery.name} - Rede Observação']"
  end

  test 'should GET acervos/documentos' do
    get documentos_galleries_path
    assert_response :success
    assert_select 'span', with: '(Documentos)'
  end

  test 'documents index show only published albums' do
    get documentos_galleries_path
    assert_select '.observatory__card', count: 1
  end

  test "documents index show link to album" do
    get documentos_galleries_path
    assert_select 'a', href: "/acervos/#{@gallery.name}?t=documentos"
  end
end
