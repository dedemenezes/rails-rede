RSpec.describe Video, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:url) }
    it 'is expected to validate that :url format is valid' do
      video = Video.new
      expect(video.invalid?).to eq(true)
      expect(video.errors).to include(:url)
      expect(video.errors.full_messages).to include('Url não é válido')

      ['htt://www.flamengo.com', 'ww.flamengo.com'].each do |invalid_url|
        video.url = invalid_url
        expect(video.invalid?).to be_truthy
        expect(video.errors).to include(:url)
        expect(video.errors.full_messages).to include('Url não é válido')
      end

      ['www.flamengo.com.br', 'http://www.flamengo.com', 'https://www.flamengo.com',
       'https://flamengo.com.br'].each do |url|
        video.url = url
        video.valid?
        expect(video.errors.include?(:url)).to be_falsey
      end
    end

    it 'is expected to set youtube video id' do
      video = build(:still_valid)
      video.valid?
      expect(video.yt_id).to eq('_CL6n0FJZpk')
    end

    it 'is expected to strip url before validation' do
      video = Video.new url: '         www.flamengo.com         '
      video.valid?
      expect(video.url).to eq('www.flamengo.com')
    end
  end
end
