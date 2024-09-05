require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "Callbacks" do
    context 'after_validation' do
      it 'sets yt_id correctly after validation for valid URLs' do
        video = build(:still_valid)
        video.valid?
        expect(video.yt_id).to eq('_CL6n0FJZpk')
      end

      it 'does not set yt_id for invalid URLs' do
        video = build(:still_valid, url: 'invalid-url')
        video.valid?
        expect(video.yt_id).to be_nil
      end
    end

    context 'before_validation' do
      it 'strips the url from any trailing space' do
        video = build(:still_valid, url: " \n https://www.youtube.com/watch?v=_CL6n0FJZpk  \n")
        video.valid?
        expect(video.url).to eq('https://www.youtube.com/watch?v=_CL6n0FJZpk')
      end
    end
  end
end
