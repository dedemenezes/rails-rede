require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "::with_documents" do
    albums(:unpublished_with_documents)
    albums(:published_with_one_document)
    assert_equal 2, Album.with_documents.length
  end

  test "::published_with_documents" do
    albums(:unpublished_with_documents)
    albums(:published_with_one_document)
    assert_equal 1, Album.published_with_documents.length
  end

  test "::with_photos" do
    albums(:unpublished_with_photos)
    albums(:published_with_one_photo)
    assert_equal 2, Album.with_photos.length
  end

  test "::published_with_photos" do
    albums(:unpublished_with_photos)
    albums(:published_with_one_photo)
    assert_equal 1, Album.published_with_photos.length
    assert_equal 1, Album.published_with_photos.first.photos.length
  end
end
