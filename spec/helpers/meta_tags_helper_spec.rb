require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MetaTagsHelper. For example:
#
# describe MetaTagsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MetaTagsHelper, type: :helper do
  describe '#meta_title' do
    context 'when used with content_for' do
      it 'return the correct title' do
        content_for :meta_title, 'Gabigol'
        # binding.break
        expect(meta_title).to eq("Gabigol")
      end
    end
    context 'when not used with content_for' do
      it 'return the correct title' do
        # binding.break
        expect(meta_title).to eq(DEFAULT_META["meta_title"])
      end
    end
  end

  describe '#meta_description' do
    context 'when used with content_for' do
      it 'return the correct description' do
        content_for :meta_description, 'Gabigol'
        # binding.break
        expect(meta_description).to eq("Gabigol")
      end
    end
    context 'when not used with content_for' do
      it 'return the correct description' do
        # binding.break
        expect(meta_description).to eq(DEFAULT_META["meta_description"])
      end
    end
  end
end
