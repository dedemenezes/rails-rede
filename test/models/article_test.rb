require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test 'Fixture' do
    article = articles(:one_featured)
    assert_instance_of Article, article
    assert  true, article.banner.attached?
    assert_equal "<div>Hello, world.</div>", article.rich_body.body.to_html
    article.destroy
  end

  test 'cannot remove featured flag if it would result in no featured articles' do
    article = articles(:one_featured)

    article.featured = false

    refute article.valid?
    assert_includes article.errors, :featured
  end

  test 'does not add error when there is another featured article' do
    project = projects(:one)
    article = Article.new(header: 'New TEST article header', sub_header: 'HEre is the new TEST sub header', featured: false, project:)
    assert article.valid?
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
    project_article = articles(:one_featured)
    actual = Article.find_by_writer('Test Project')
    assert_equal [project_article], actual
  end
end
