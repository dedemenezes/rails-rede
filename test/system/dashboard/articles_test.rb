require "application_system_test_case"

class Dashboard::ArticlesTest < ApplicationSystemTestCase
  test "visiting the index" do
    sign_in users(:coppola)
    visit dashboard_articles_url

    assert_selector "h1", text: "Notícia"
    assert_link 'Novo(a)', href: /new/
  end

  test "creates a new article" do
    tags(:one)
    projects(:one)

    assert_difference("Article.count", 1) do
      sign_in users(:coppola)
      visit '/dashboard/articles/new'

      check 'article[featured]', allow_label_click: true
      select 'TEST tag', from: 'article[tag_ids][]'
      click_button 'project', wait: true
      select 'Project', from: 'article[project_id]'
      attach_file 'article[banner]', Rails.root.join('test', 'fixtures', 'files', 'e.png'), make_visible: true
      fill_in 'article[header]', with: 'Here is the test title Flamengo wins Copa do Brasil'
      fill_in 'article[sub_header]', with: 'Here is the test sub-title Flamengo wins Copa do Brasil'
      fill_in_rich_text_area 'article_rich_body', with: 'Rich text from <em>TEST</em>'
      click_button 'commit'

      assert_current_path dashboard_articles_path
    end
  end
end
