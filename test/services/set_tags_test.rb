require 'test_helper'

class SetTagsTest < ActiveSupport::TestCase
  test '::extract_model_name' do
    assert :article, SetTags.extract_model_name(articles(:one_featured))
    assert :unity_type, SetTags.extract_model_name(unity_types(:one))
  end
end
