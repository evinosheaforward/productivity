require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

	def setup
		@user = users(:evin)
	end

	test "profile display" do
		get user_path(@user)
		assert_template 'users/show'
		assert_select 'title', full_title(@user.name)
		assert_select 'h1', text: @user.name
		assert_match @user.accomplishments.count.to_s, response.body
		assert_select 'div.pagination'
		@user.accomplishments.paginate(page: 1).each do |acc|
			assert_match acc.name, response.body
		end
	end
end
