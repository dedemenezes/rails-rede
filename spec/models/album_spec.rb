require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'Validation' do
    it { should validate_inclusion_of(:category).in_array(['document', 'photo']) }
  end

  describe "Association" do
    it { should have_many_attached(:photos) }
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
  end

  describe 'Scopes' do
    context '::only_published_events' do
      before(:each) do
        create(:published_event_album)
        create(:unpublished_event_album)
      end

      it 'returns a ActiveRecord::Relation' do
        expect(subject.class.only_published_events).to be_a(ActiveRecord::Relation)
      end
      it 'returns the only published events' do
        expect(subject.class.only_published_events.size).to eq(1)
      end
    end
  end
end
