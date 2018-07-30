require 'test_helper'

class AccomplishmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accomplishment = accomplishments(:one)
  end

  test "should get index" do
    get accomplishments_url
    assert_response :success
  end

  test "should get new" do
    get new_accomplishment_url
    assert_response :success
  end

  test "should create accomplishment" do
    assert_difference('Accomplishment.count') do
      post accomplishments_url, params: { accomplishment: { date: @accomplishment.date, name: @accomplishment.name, time_productive: @accomplishment.time_productive, time_working: @accomplishment.time_working } }
    end

    assert_redirected_to accomplishment_url(Accomplishment.last)
  end

  test "should show accomplishment" do
    get accomplishment_url(@accomplishment)
    assert_response :success
  end

  test "should get edit" do
    get edit_accomplishment_url(@accomplishment)
    assert_response :success
  end

  test "should update accomplishment" do
    patch accomplishment_url(@accomplishment), params: { accomplishment: { date: @accomplishment.date, name: @accomplishment.name, time_productive: @accomplishment.time_productive, time_working: @accomplishment.time_working } }
    assert_redirected_to accomplishment_url(@accomplishment)
  end

  test "should destroy accomplishment" do
    assert_difference('Accomplishment.count', -1) do
      delete accomplishment_url(@accomplishment)
    end

    assert_redirected_to accomplishments_url
  end
end
