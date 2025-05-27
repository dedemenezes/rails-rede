require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "email must be unique (case insensitive)" do
    user1 = User.create!(email: "test@example.com", first_name: "Test", last_name: "User", password: 123456)
    user2 = User.new(email: "TEST@example.com", first_name: "Test", last_name: "User")

    assert_not user2.valid?
    assert_includes user2.errors[:email], "já está em uso"
  end

  test "first_name must be unique scoped to last_name" do
    User.create!(email: "unique@example.com", first_name: "John", last_name: "Doe", password: 123456)
    user = User.new(email: "another@example.com", first_name: "John", last_name: "Doe")

    assert_not user.valid?
    assert_includes user.errors[:first_name], "já está em uso"
  end

  test "can attach an avatar" do
    user = users(:coppola)
    assert_respond_to user, :avatar
  end

  test "#full_name concatenates and titleizes first and last name" do
    user = User.new(first_name: "francis", last_name: "coppola")
    assert_equal "Francis Coppola", user.full_name
  end

  test "#full_name works with fixtures" do
    user = users(:coppola)
    assert_equal "Francis Coppola", user.full_name
  end
end
