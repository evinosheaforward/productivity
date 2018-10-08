class AccomplishmentsController < ApplicationController
	before_action :logged_in_user, 	only: [:index, :create, :edit, :update, :destroy]
	before_action :correct_user,		only: [:destroy, :show, :edit, :update]

	def index
	  @accomplishments = current_user.accomplishments.all

	  respond_to do |format|
	    format.html
	    format.json { render json: @accomplishments }
	  end
	end

	def new
	end

	def create
		@accomplishment = current_user.accomplishments.build(accomplishment_params)
		if @accomplishment.save
			flash[:success] = "Accomplishment created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

  def destroy
		@accomplishment.destroy
		flash[:success] = "Accomplishment deleted"
		redirect_to request.referrer || root_url
  end

	def edit
	end

	def update
		if @accomplishment.update(accomplishment_params)
			redirect_to @accomplishment
			flash[:sucess] = "Accomplishment was successfully updated."
		else
			render :edit
			flash[:danger] = "Unsuccessful update for the accomplishment."
		end
	end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def accomplishment_params
      params.require(:accomplishment).permit(:name, :timeWorking, :timeProductive, :date)
    end

		def correct_user
			@accomplishment = current_user.accomplishments.find_by(id: params[:id])
			redirect_to root_url if @accomplishment.nil?
		end
end
