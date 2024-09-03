require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test '::dashboard_headers' do
    assert_equal %w[id banner header featured? published], Article.dashboard_headers
  end

  test '::featured' do
    create(:article)
    featured = create(:article_featured)
    assert_equal featured, Article.featured
  end

  test '::any_present?' do
    refute Article.any_present?
    assert 0, Article.count

    create(:article_featured)
    assert Article.any_present?
  end


  test '::find_by_writer' do
    featured = create(:article_featured)
    article = create(:article)
    actual = Article.find_by_writer('Rede Observacao')
    assert actual
    assert_equal [featured, article], actual
  end
end
