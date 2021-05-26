class ApplicationPetsController < ApplicationController

  def create
    @application = Application.find(params[:application])
    @pet = Pet.find(params[:pet])
    ApplicationPet.create(pet: @pet, application: @application)
    redirect_to "/applications/#{@application.id}"
    # if @join.save
    #   redirect_to "/applications/#{@application.id}"
    # else
    #   redirect_to "/applications/#{@application.id}"
    #   flash[:alert] = "Error: #{error_message(@join.errors)}"
    # end
  end

  private

  def application_params
    params.permit(:pet, :application)
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
