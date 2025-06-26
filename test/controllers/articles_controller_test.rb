require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index and have content" do
    not_featured_obs = articles(:not_featured_obs)
    not_featured_obs.update(main_featured: true)
    get articles_url
    assert_response :success
    assert_select "h1", "Notícias"
  end

  test "should show article and have content" do
    article = articles(:one_featured)
    get article_url(article)
    assert_response :success
    assert_select "h1", article.header
  end

  test "should show article when url contains only the header (old routing)" do
    article = articles(:one_featured)
    get  article_url(article.header)
    assert_response :success
    assert_select "h1", article.header
  end
end
