require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test 'Fixture' do
    article = articles(:one_featured)
    assert_instance_of Article, article
    assert  true, article.banner.attached?
    assert_equal "<div>Hello, world.</div>", article.rich_body.body.to_html
    article.destroy
  end

  test '::dashboard_headers' do
    assert_equal %w[id banner header featured? published], Article.dashboard_headers
  end

  test '::featured' do
    featured = articles(:one_featured)
    not_featured = articles(:one_not_featured)
    refute Article.featured == not_featured
    assert_equal featured, Article.featured
  end

  test '::any_present?' do
    articles(:one_featured)
    assert_equal true, Article.any_present?
  end


  test '::find_by_writer' do
    featured = create(:article_featured)
    article = create(:article)
    actual = Article.find_by_writer('Rede Observacao')
    assert actual
    assert_equal [featured, article], actual
  end
end
