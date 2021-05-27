require 'rails_helper'

RSpec.describe 'the admin application show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @pet_4 = @shelter_1.pets.create(name: 'Sam', breed: 'Persian', age: 2, adoptable: true)
    @application = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', status: 'Pending')
    @application_2 = Application.create(name: 'Master Danpe', address_street: '555 Tamis crt.', address_city: 'Fryer', address_state: 'CO', address_zip: '80525', status: 'In Progress')
    ApplicationPet.create(application: @application, pet: @pet_1)
    ApplicationPet.create(application: @application, pet: @pet_2)
    ApplicationPet.create(application: @application_2, pet: @pet_3)
  end
  describe 'visit a show page' do
    it 'should have approve buttons next to each pet' do

      visit "/admin/applications/#{@application.id}"


      expect(page).to have_button('Approve', count: 2)
    end

    it 'should remove the approve button and show Approved when clicked' do
      visit "/admin/applications/#{@application.id}"

      expect(page).to_not have_content('Approved')

      within('li#0') do
        click_button('Approve')
      end

      expect(page).to have_button('Approve')
      expect(page).to have_content('Approved')
    end
  end
end
