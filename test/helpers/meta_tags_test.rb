require 'test_helper'

class MetaTagsHelperTest < ActionView::TestCase
  test '#meta_title returns content_for title if set' do
    content_for :meta_title, 'Gabigol'
    assert_equal 'Gabigol', meta_title
  end

  test '#meta_title returns default title if content_for not set' do
    assert_equal DEFAULT_META["meta_title"], meta_title
  end

  test '#meta_description returns content_for description if set' do
    content_for :meta_description, 'Gabigol'
    assert_equal 'Gabigol', meta_description
  end

  test '#meta_description returns default description if content_for not set' do
    assert_equal DEFAULT_META["meta_description"], meta_description
  end
end
