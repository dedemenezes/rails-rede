require "test_helper"

class Dashboard::ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:coppola)
  end

  test "update writer to methodology" do
    methodology = create(:flamenguismo)
    article = create(:observatory_article_featured)

    assert_changes -> { Article.find(article.id).values_at(:observatory_id, :methodology_id) } do
      patch dashboard_article_url(article), params: { article: {project_id: "", observatory_id: "", methodology_id: methodology.id } }
    end
  end

  test "update writer to observatory" do
    methodology = create(:flamenguismo)
    article = create(:observatory_article_featured, methodology_id: methodology.id, observatory_id: '')
    ninho = create(:ninho_do_urubu)
    assert_changes -> { Article.find(article.id).values_at(:observatory_id, :methodology_id) } do
      patch dashboard_article_url(article), params: { article: {project_id: "", observatory_id: ninho.id, methodology_id: '' } }
    end
  end

  test "update writer to project" do
    rede = create(:rede)
    article = create(:observatory_article_featured)

    assert_changes -> { Article.find(article.id).values_at(:project_id, :methodology_id) } do
      patch dashboard_article_url(article), params: { article: {project_id: rede.id, observatory_id: "", methodology_id: '' } }
    end
  end

  test "should update project with valid attributes" do
    project = create(:rede)
    id = project.id
    assert 'Rede Observacao', project.name
    assert "Rede ObservacaoRede ObservacaoRede ObservacaoRede Observacao", project.banner_text
    assert_changes -> { Project.find(id).values_at(:name, :banner_text) } do
      patch dashboard_project_url(project), params: { project: {
        name: 'UPDATED Rede',
        banner_text: 'Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!',
        } }
      end
      assert 'Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!Hello Rails!', Project.find(id).name


      assert_redirected_to dashboard_projects_path
    end

    test "should update article" do
      tag_one = create(:tag)
      new_tag = create(:second_tag)
      article = create(:observatory_article_featured, tags: [tag_one])
      id = article.id
      assert 'FEATURED This is a very nice header for this article', article.header
      # p Article.find(id).tags
      assert_changes -> { Article.find(id).values_at(:published, :header, :tag_ids, :banner_subtitle) } do
        patch dashboard_article_url(article), params: { article: {
          published: false,
          header: 'Hello Rails!',
          tag_ids: [tag_one.id, new_tag.id],
          banner_subtitle: 'aqui está a legenda do banner'
      } }
    end
    assert Article.find(id).tags.include?(new_tag)
    assert 'Hello Rails!', Article.find(id).header

    assert_redirected_to dashboard_articles_path
  end

  test "should NOT update article" do
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
    # p Article.find(id).tags
    assert_no_difference -> { Article.count } do
      post dashboard_articles_url, params: { article: { header: '' } }
    end
    assert_response :unprocessable_entity
  end

  test "should destroy an article" do

    article = create(:observatory_article_featured)
    assert_difference("Article.count", -1) do
      delete dashboard_article_url(article)
    end

    assert_redirected_to dashboard_articles_path
  end

end
