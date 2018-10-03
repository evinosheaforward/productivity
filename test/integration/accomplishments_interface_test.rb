require 'test_helper'

class AccomplishmentsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:evin)
	end

	test "accomplishment interface" do
    log_in_as(@user)
		get root_path
		# Posts NOT shown on home page
		# assert_select 'div.pagination'
		# Invalid submission
		assert_no_difference 'Accomplishment.count' do
			post accomplishments_path, params: { accomplishment: { 	name: "",
																															timeWorking: 6,
																															timeProductive: 5,
																															date: Time.zone.now } }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		name = "Any Task"
		assert_difference 'Accomplishment.count', 1 do
			post accomplishments_path, params: { accomplishment: { 	name: name,
																															timeWorking: 6,
																															timeProductive: 5,
																															date: Time.zone.now } }
		end
		assert_redirected_to root_url
		get user_path(@user)
		assert_match name, response.body
		# Delete accomplishment
		assert_select 'a', text: 'delete'
		first_accomplishment = @user.accomplishments.paginate(page: 1).first
		assert_difference 'Accomplishment.count', -1 do
			delete accomplishment_path(first_accomplishment)
  	end
		# Visit different user
		get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
	end
end
