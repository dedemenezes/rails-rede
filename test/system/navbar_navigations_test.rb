require "application_system_test_case"

class NavbarNavigationsTest < ApplicationSystemTestCase
  test "Navigating through the navbar" do
    observatory = observatories(:ninho_do_urubu)
    articles(:one_not_featured).update(main_featured: true)

    visit root_path

    assert_selector "h1", text: "osfhdsf sdofhsdfjsofh fsd fosd f isdhf jsfn kdjsdfs asdad dasd ass"
    assert_selector "button", id: "observatory-dropdown-toggler"

    click_button("observatory-dropdown-toggler")
    assert_selector "div.dropdown-menu.show"
    assert_link "Ninho do Urubu"

    click_button("acervos-dropdown-toggler")
    assert_selector "div.dropdown-menu.show"
    assert_link "Ninho do Urubu"
  end
end
