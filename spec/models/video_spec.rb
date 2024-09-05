require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '::published' do
    it 'is expected to return only published videos' do
      create(:still_valid)
      expect(Video.published.length).to eq(0)

      create(:still_valid, published: true)
      expect(Video.published.length).to eq(1)
      create(:still_valid, published: true)
      expect(Video.published.length).to eq(2)
    end
  end

  describe '#thumbnail' do
    it 'is expected to return correct youtube url' do
      video = create(:still_valid)
      expect(video.thumbnail).to eq('https://img.youtube.com/vi/_CL6n0FJZpk/hqdefault.jpg')
    end

    it 'is expected to return empty string when no youtube id is set' do
      video = build(:still_valid)
      video.yt_id = ''
      expect(video.thumbnail).to eq('')
    end
  end
end
