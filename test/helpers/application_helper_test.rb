require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test '#route_for_edit_dashboard' do
    # ARTICLE
    article = articles(:one_featured)
    expected = "articles/#{article.to_param}/edit"
    actual = route_for_edit_dashboard(article)
    assert_equal expected, actual

    # ALBUMS
    methodology = methodologies(:flamenguismo)
    expected = "methodologies/#{methodology.to_param}/edit"
    actual = route_for_edit_dashboard(methodology)
    assert_equal expected, actual
  end
end
