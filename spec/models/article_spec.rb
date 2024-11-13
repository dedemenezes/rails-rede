require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:header) }
    it { should validate_uniqueness_of(:header) }
  end

  describe 'Associations' do
    it { should have_one_attached(:banner) }
  end

  describe '#featured?' do
    it 'returns the right emoji' do
      article = build(:article)
      expect(article.featured?).to eq('❌')
      article.featured = true
      expect(article.featured?).to eq('✅')
    end
  end

  describe '#observatory_name' do
    it 'returns the observatory name' do
      article = build(:observatory_article_featured)
      expect(article.observatory_name).to eq('Ninho do Urubu')
      article.observatory = nil
      expect(article.observatory_name).to eq(nil)
    end
  end
end
