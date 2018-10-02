class StaticPagesController < ApplicationController

	def home
    @accomplishment = current_user.accomplishments.build if logged_in?
  end
end
