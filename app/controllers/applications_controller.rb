class ApplicationsController < ApplicationController

  def welcome

  end

  def show
    if params[:search].present?
      @application = Application.find(params[:id])
      @pets = @application.pets
      @pets_2 = Pet.pet_search(params[:search])
    else
      @application = Application.find(params[:id])
      @pets = @application.pets
    end
  end

  def new

  end

  def create
    @application = Application.new(application_params)

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  private

  def application_params
    params.permit(:name, :address_street, :address_city, :address_state, :address_zip, :description, :status)
    .merge(status: 'Pending')
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
