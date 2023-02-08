require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  describe 'Validations' do
    # binding.break
    it 'validate_uniqueness_of :tag scoped_to :article' do
      # binding.break
      expect(ArticleTag.count).to eq(0)
      tag = create(:tag)
      article = create(:article)
      article_tags_one = described_class.create(tag: tag, article: article)
      expect(ArticleTag.count).to eq(1)
      article_tags_two = described_class.create(tag: tag, article: article)
      invalid_tag = article_tags_two.errors.messages.include? :tag
      expect(invalid_tag).to be_truthy
    end
  end
end
