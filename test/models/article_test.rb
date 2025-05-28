require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test 'Fixture' do
    article = articles(:one_featured)
    assert_instance_of Article, article
    assert  true, article.banner.attached?
    assert_equal "<div>Hello, world.</div>", article.rich_body.body.to_html
    article.destroy
  end

  test 'when set as featured stored featured_at' do
    # get article
    article = articles(:not_featured_obs)
    # set as featured
    article.update(featured: true)
    # ensure featured_at same as updated_at
    assert article.reload.featured_at
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

  test 'cannot have more than 3 featured articles' do
    project = projects(:one)

    one_featured = articles(:one_featured)
    not_featured_obs = articles(:not_featured_obs)
    one_not_featured = articles(:one_not_featured)
    assert_equal 1, Article.where(featured: true).count
    not_featured_obs.update(featured: true)
    assert_equal 2, Article.where(featured: true).count
    one_not_featured.update(featured: true)
    assert_equal 3, Article.where(featured: true).count

    new_article = Article.create(header: 'Test article', featured: false, published: true, project:)
    new_article.update(featured: true)
    assert_equal 3, Article.where(featured: true).count
    refute Article.find(one_featured.id).featured

    assert new_article.reload.featured
  end

  test '::dashboard_headers' do
    assert_equal %w[id banner header featured? published], Article.dashboard_headers
  end

  test 'all_featured scope returns up to 3 articles ordered by featured_at desc' do
    project = projects(:one)
    one_featured = articles(:one_featured)
    not_featured_obs = articles(:not_featured_obs)
    one_not_featured = articles(:one_not_featured)

    5.times do |i|
      Article.create!(header: "featured_test_header_#{i+1}", project:, featured: false, published: true)
    end

    assert_equal 1, Article.all_featured.size

    one_not_featured.update(featured: true, featured_at: 2.minutes.ago)
    assert_equal 2, Article.all_featured.size

    not_featured_obs.update(featured: true, featured_at: 1.minute.ago)
    assert_equal 3, Article.all_featured.size

    all_featured = Article.all_featured
    assert_equal not_featured_obs, all_featured.first, 'last featured should be first item'
    assert_equal one_not_featured, all_featured.second, 'last featured should be second item'
    assert_equal one_featured, all_featured.third, 'last featured should be third item'
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

  test "is invalid without a header" do
    article = Article.new
    assert_not article.valid?
    assert_includes article.errors[:header], "não pode ficar em branco"
  end

  test "is invalid with a non-unique header" do
    existing_article = articles(:one_featured)
    article = Article.new(header: existing_article.header)

    assert_not article.valid?
    assert_equal article.errors[:header], ["já está em uso"]
  end

  test "has one attached banner" do
    article = Article.new
    assert_respond_to article, :banner
  end

  test "#featured? returns the correct emoji" do
    article = Article.new(featured: false)
    assert_equal "❌", article.featured?

    article.featured = true
    assert_equal "✅", article.featured?
  end

  test "#observatory_name returns the name when observatory exists" do
    article = articles(:not_featured_obs)
    assert_equal "Ninho do Urubu", article.observatory_name
  end

  test "#observatory_name returns nil when observatory is nil" do
    article = articles(:not_featured_obs)
    article.observatory = nil
    assert_nil article.observatory_name
  end
end
