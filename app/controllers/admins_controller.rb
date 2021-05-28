class AdminsController < ApplicationController

  def shelters
    @shelters = Shelter.order_by_name_reverse
    @shelters_app = Shelter.has_pets_with_apps
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    admin_check = @application.approval_check
    if admin_check == 'Approved'
      @application.update!(status: admin_check, description: @application.description)
      @application.adopt_pets
    elsif admin_check == 'Rejected'
      @application.update!(status: admin_check, description: @application.description)
    end
  end

end
