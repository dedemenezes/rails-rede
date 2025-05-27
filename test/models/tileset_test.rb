require "test_helper"

class TilesetTest < ActiveSupport::TestCase
  test 'validate presence of name and mapbox_id' do
    tileset = Tileset.new
    tileset.valid?
    messages = tileset.errors.messages

    assert_includes tileset.errors, :name
    assert_includes messages[:name], 'não pode ficar em branco'
    assert_includes tileset.errors, :mapbox_id
    assert_includes messages[:mapbox_id], 'não pode ficar em branco'
  end

  test 'should strip name from any trailing space before validation' do
    tileset = tilesets(:arraial_tile)
    tileset.name = " \n Tileset Test  \n"
    tileset.valid?  # triggers before_validation
    assert_equal 'Tileset Test', tileset.name
  end

  test '#replace_non_ascii_with_ascii replaces non-ascii characters with ascii' do
    tileset = Tileset.new
    input = 'A visão quiÇÁ está inútil'
    expected = 'A visao quiCA esta inutil'
    actual = tileset.replace_non_ascii_with_ascii(input)
    assert_equal expected, actual
  end
end
