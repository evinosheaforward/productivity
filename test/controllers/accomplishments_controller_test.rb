require 'test_helper'

class AccomplishmentsControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:evin)
    @accomplishment = @user.accomplishments.build(name: "Lorem ipsum", timeWorking: 10, timeProductive: 8)
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
end
