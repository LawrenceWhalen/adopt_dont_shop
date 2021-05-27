class AdminsController < ApplicationController

  def shelters
    @shelters = Shelter.order_by_name_reverse
    @shelters_app = Shelter.has_pets_with_apps
  end

end
