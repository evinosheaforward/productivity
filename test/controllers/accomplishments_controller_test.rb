require 'test_helper'

class AccomplishmentsControllerTest < ActionDispatch::IntegrationTest

	def setup
    @accomplishment = accomplishments(:one)
  end

	test "should redirect create when not logged in" do
		assert_no_difference 'Accomplishment.count' do
			post accomplishments_path, params: { accomplishment: { 	name: "Lorem ipsum",
																															timeWorking: 50,
																															timeProductive: 20,
																															date: Time.zone.now}}
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Accomplishment.count' do
			delete accomplishment_path(@accomplishment)
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy for wrong accomplishment" do
		log_in_as(users(:evin))
		accomplishment = accomplishments(:three)
		assert_no_difference 'Accomplishment.count' do
			delete accomplishment_path(accomplishment)
		end
		assert_redirected_to root_url
	end

  test "should be valid" do
    assert @accomplishment.valid?
  end

  test "user id should be present" do
    @accomplishment.user_id = nil
		assert_not @accomplishment.valid?
  end

	test "name should be present" do
		@accomplishment.name = "    "
		assert_not @accomplishment.valid?
	end

	test "name should be at most 60 characters" do
		@accomplishment.name = "a" * 61
		assert_not @accomplishment.valid?
	end

	test "timeWorking should be numerical" do
		@accomplishment.timeWorking = "hello"
		assert_not @accomplishment.valid?
	end

	test "timeProductive should be numerical" do
		@accomplishment.timeProductive = "hello"
		assert_not @accomplishment.valid?
	end

	test "timeProductive should be less than timeWorking" do
		@accomplishment.timeProductive = 12.0
		@accomplishment.timeWorking = 10.0
		assert_not @accomplishment.valid?
	end

	test "order should be most recent first" do
		assert_equal accomplishments.sort_by { |acc| acc[:date] }.last, Accomplishment.first
	end
end
