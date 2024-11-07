require "test_helper"

class Dashboard::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should update article" do
    sign_in users(:coppola)
    tag_one = create(:tag)
    new_tag = create(:second_tag)
    article = create(:observatory_article_featured, tags: [tag_one])
    id = article.id
    assert 'FEATURED This is a very nice header for this article', article.header
    # p Article.find(id).tags
    assert_changes -> { Article.find(id).values_at(:published, :header, :tag_ids) } do
      patch dashboard_article_url(article), params: { article: { published: false, header: 'Hello Rails!', tag_ids: [tag_one.id, new_tag.id] } }
    end
    assert Article.find(id).tags.include?(new_tag)
    assert 'Hello Rails!', Article.find(id).header

    assert_redirected_to dashboard_articles_path
  end

  test "should NOT update article" do
    sign_in users(:coppola)
    article = create(:observatory_article_featured)
    id = article.id
    assert 'FEATURED This is a very nice header for this article', article.header
    # p Article.find(id).tags
    assert_no_changes -> { Article.find(id).values_at(:header) } do
      patch dashboard_article_url(article), params: { article: { header: '' } }
    end
    assert_response :unprocessable_entity
  end

  test "should NOT create article" do
    sign_in users(:coppola)
    # p Article.find(id).tags
    assert_no_difference -> { Article.count } do
      post dashboard_articles_url, params: { article: { header: '' } }
    end
    assert_response :unprocessable_entity
  end

  test "should destroy an article" do
    sign_in users(:coppola)

    article = create(:observatory_article_featured)
    assert_difference("Article.count", -1) do
      delete dashboard_article_url(article)
    end

    assert_redirected_to dashboard_articles_path
  end

end
