require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '#strip_video_id' do
    context 'from YouTube full URL' do
      it 'returns the correct video_id attrbibute' do
        project = Project.new video_id: 'https://www.youtube.com/watch?v=ccuc6dgTec1'
        expect(project.strip_video_id).to eq("ccuc6dgTec1")
      end
    end
    context 'from YouTube shortned URL' do
      it 'returns the correct video_id attrbibute' do
        project = Project.new video_id: 'https://youtu.be/ccuc6dgTec2'
        expect(project.strip_video_id).to eq("ccuc6dgTec2")
      end
    end
  end
end
