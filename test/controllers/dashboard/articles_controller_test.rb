require "test_helper"

class Dashboard::ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:coppola)
  end

  test "creates first article and sets it as featured automatically" do
    Article.destroy_all
    project = projects(:one)

    valid_params = {
      header: 'FEATURED Test Article',
      sub_header: 'TEST article subheader',
      published: true,
      rich_body: "<div>Hello, world!</div>",
      project_id: project.id
    }
    assert_difference('Article.count', 1) do
      post dashboard_articles_url, params: { article: valid_params }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_predicate Article.last, :featured
  end

  test 'ensures only one article is featured at a time after update' do
    project = projects(:one)

    valid_params = {
      header: 'FEATURED Test Article',
      sub_header: 'TEST article subheader',
      published: true,
      rich_body: "<div>Hello, world!</div>",
      project_id: project.id
    }
    previously_featured = articles(:one_featured)
    not_featured = articles(:one_not_featured)

    assert_changes -> { Article.find(not_featured.id).featured } do
      patch dashboard_article_url(not_featured), params: { article: { featured: true } }
    end

    not_featured.reload
    previously_featured.reload

    assert_predicate not_featured, :featured
    refute_predicate previously_featured, :featured
  end

  test 'deleting featured article promotes lastest updated to featured' do
    featured = articles(:one_featured)
    not_featured = articles(:one_not_featured)

    refute_predicate not_featured, :featured
    assert_predicate featured, :featured

    assert_changes -> { Article.find(not_featured.id).values_at(:featured) } do
      delete dashboard_article_url(featured)
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "update writer to methodology" do
    methodology = methodologies(:flamenguismo)
    article = articles(:one_featured)
    ninho = observatories(:ninho_do_urubu)
    assert_changes -> { Article.find(article.id).values_at(:project_id, :methodology_id) } do
      patch dashboard_article_url(article), params: { article: {header: "NEW UPDATED HEADER", project_id: "", observatory_id: "", methodology_id: methodology.id } }
    end
  end

  test "update writer to observatory" do
    methodology = methodologies(:flamenguismo)
    article = articles(:one_not_featured)
    ninho = observatories(:ninho_do_urubu)
    assert_changes -> { Article.find(article.id).values_at(:observatory_id, :methodology_id) } do
      patch dashboard_article_url(article), params: { article: { project_id: "", observatory_id: ninho.id, methodology_id: '' } }
    end
  end

  test "update writer to project" do
    project = projects(:one)
    article = articles(:one_not_featured)

    assert_changes -> { Article.find(article.id).values_at(:project_id, :methodology_id) } do
      patch dashboard_article_url(article), params: { article: {project_id: project.id, observatory_id: "", methodology_id: '' } }
    end
  end

  test "should update project with valid attributes" do
    project = projects(:one)
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
      tag_one = tags(:one)
      new_tag = tags(:two)
      article = articles(:one_featured)
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
    article = articles(:one_featured)
    id = article.id
    assert 'FEATURED Projeto Alicerce dobra número de participantes e fortalece educação comunitária em Búzios', article.header
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

    article = articles(:one_featured)
    assert_difference("Article.count", -1) do
      delete dashboard_article_url(article)
    end

    assert_redirected_to dashboard_articles_path
  end

end
