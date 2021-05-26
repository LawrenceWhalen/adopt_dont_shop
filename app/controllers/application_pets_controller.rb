class ApplicationPetsController < ApplicationController

  def create
    application = Application.find(params[:application])
    pet = Pet.find(params[:pet])

    join = ApplicationPet.new(pet: pet, application: application)

    if join.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: #{error_message(join.errors)}"
    end

    # if ApplicationPet.where(pet_id: "#{@pet.id}", application_id: "#{@application.id}") == []
    #   @join.save
    #   redirect_to "/applications/#{@application.id}"
    # else
    #   redirect_to "/applications/#{@application.id}"
    #   flash[:alert] = "Error: Pet already on application"
    # end
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
