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
  end

  def update
    status_update = ApplicationPet.find(params[:id])
    status_update.update(pet_status: params[:status])
    redirect_to "/admin/applications/#{status_update.application_id}"
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
