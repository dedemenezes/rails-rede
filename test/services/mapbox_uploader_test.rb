require 'test_helper'

class MapboxUploaderTest < ActiveSupport::TestCase
  test '#ensure_valid_name' do
    name = 'São Francisco de Itabapoana'
    subject = MapboxUploader.new(tileset_name: name, file_path: "#{name}_path")
    assert_equal 'são_francisco_de_itabapoana', subject.tileset_name

  end
end
