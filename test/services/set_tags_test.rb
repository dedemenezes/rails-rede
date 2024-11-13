require 'test_helper'

class SetTagsTest < ActiveSupport::TestCase
  test '::extract_model_name' do
    assert :article, SetTags.extract_model_name(create(:article))
    assert :unity_type, SetTags.extract_model_name(create(:unity_type))
  end
end
