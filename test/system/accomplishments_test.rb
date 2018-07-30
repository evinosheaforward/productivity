require "application_system_test_case"

class AccomplishmentsTest < ApplicationSystemTestCase
  setup do
    @accomplishment = accomplishments(:one)
  end

  test "visiting the index" do
    visit accomplishments_url
    assert_selector "h1", text: "Accomplishments"
  end

  test "creating a Accomplishment" do
    visit accomplishments_url
    click_on "New Accomplishment"

    fill_in "Date", with: @accomplishment.date
    fill_in "Name", with: @accomplishment.name
    fill_in "Time Productive", with: @accomplishment.time_productive
    fill_in "Time Working", with: @accomplishment.time_working
    click_on "Create Accomplishment"

    assert_text "Accomplishment was successfully created"
    click_on "Back"
  end

  test "updating a Accomplishment" do
    visit accomplishments_url
    click_on "Edit", match: :first

    fill_in "Date", with: @accomplishment.date
    fill_in "Name", with: @accomplishment.name
    fill_in "Time Productive", with: @accomplishment.time_productive
    fill_in "Time Working", with: @accomplishment.time_working
    click_on "Update Accomplishment"

    assert_text "Accomplishment was successfully updated"
    click_on "Back"
  end

  test "destroying a Accomplishment" do
    visit accomplishments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Accomplishment was successfully destroyed"
  end
end
