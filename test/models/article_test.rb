require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test 'Fixture' do
    article = articles(:one_featured)
    assert_instance_of Article, article
    assert  true, article.banner.attached?
    assert_equal "<div>Hello, world.</div>", article.rich_body.body.to_html
    article.destroy
  end

  test "main_featured article cannot be featured too" do
    article = articles(:one_featured)
    article.update(main_featured: true)
    assert article.reload.main_featured
    refute article.reload.featured, "cannot be featured"
  end

  # creating the first article must ensure it's main featured
  # must only have one main featured article
  test "must only have one main featured article" do
    featured = articles(:one_featured)
    not_featured = articles(:not_featured_obs)
    one_not_featured = articles(:one_not_featured)
    featured.update(main_featured: true)
    assert_equal 1, Article.where(main_featured: true).count
    assert_equal featured, Article.main_featured

    one_not_featured.update(main_featured: true)
    assert_equal 1, Article.where(main_featured: true).count, "must have one main featured only"
    assert_equal one_not_featured, Article.main_featured

  end

  test "removing main featured grab most recent featured_at and assign as main featured" do
    main_featured = articles(:one_featured)
    main_featured.update(main_featured: true)
    refute main_featured.reload.featured

    featured = articles(:one_not_featured)
    featured.update(featured: true)
    latest_featured = articles(:not_featured_obs)
    latest_featured.update(featured: true)

    main_featured.update(main_featured: false)

    assert latest_featured.reload.main_featured
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
    assert_equal %w[id banner header featured? published main_featured?], Article.dashboard_headers
  end

  test '::excluding_featured_and_recents returns all the other articles' do
    project = projects(:one)
    articles = 10.times.map do |i|
      Article.create!(header: "Article #{i+1}", project:, featured: false, published: true, created_at: Time.current + i.minutes)
    end
    first_three = articles.first(3)
    first_three.each { _1.update(featured: true) }
    featured_ids = first_three.map(&:id)
    recent_ids = articles[3..6].map(&:id)
    exclude_ids = featured_ids + recent_ids
    remaining_articles = Article.excluding_featured_and_recents(exclude_ids)

    fixtures_articles_count = 3
    assert_equal 3 + fixtures_articles_count, remaining_articles.size
    assert_includes remaining_articles, articles.last
  end

  test '::most_recents scope returns up to 4 articles ordered by updated_at desc' do
    project = projects(:one)
    one_featured = articles(:one_featured)
    not_featured_obs = articles(:not_featured_obs)
    one_not_featured = articles(:one_not_featured)
    assert_equal 2, Article.most_recents.size, "Should return exactly 2 articles"

    created_times = [5,4,3,2,1].map { |n| n.minutes.ago }

    recent_articles = created_times.each_with_index.map do |created_time, i|
      # 5 mais antigo que o 1
      Article.create!(
        header: "featured_test_header_#{i+1}",
        project:,
        featured: false,
        published: true,
        created_at: created_time,
        updated_at: created_time
      )
    end
    actual = Article.most_recents

    assert_equal 4, actual.size, "Should return exactly 4 articles"

    assert_equal recent_articles.reverse[0], actual[0], 'ordering is not right'
    assert_equal recent_articles.reverse[1], actual[1], 'ordering is not right'
    assert_equal recent_articles.reverse[2], actual[2], 'ordering is not right'
    assert_equal recent_articles.reverse[3], actual[3], 'ordering is not right'
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
