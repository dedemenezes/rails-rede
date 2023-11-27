require "test_helper"

class TilesetTest < ActiveSupport::TestCase
  test 'validate presence of name and mapbox_id' do
    tileset = Tileset.new
    tileset.valid?
    p tileset.errors
    messages = tileset.errors.messages
    p messages
    assert_includes tileset.errors, :name
    assert_includes messages[:name], 'não pode ficar em branco'
    assert_includes tileset.errors, :mapbox_id
    assert_includes messages[:mapbox_id], 'não pode ficar em branco'
  end
end
