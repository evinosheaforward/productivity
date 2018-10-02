class AccomplishmentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

	def create
		@accomplishment = current_user.accomplishments.build(accomplishment_params)
		if @accomplishmnet.save
			flash[:success] = "Accomplishment created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

  def destroy
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def accomplishment_params
      params.require(:accomplishment).permit(:name, :timeWorking, :timeProductive, :date)
    end
end
