require 'rails_helper'

RSpec.describe 'the admin shelters page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @pet_4 = @shelter_3.pets.create(name: 'Sam', breed: 'Persian', age: 2, adoptable: true)
    @application = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', status: 'Pending')
    @application_2 = Application.create(name: 'Master Dan', address_street: '555 Tamis crt.', address_city: 'Fryer', address_state: 'CO', address_zip: '80525', status: 'In Progress')
    ApplicationPet.create(application: @application, pet: @pet_1)
    ApplicationPet.create(application: @application, pet: @pet_2)
    ApplicationPet.create(application: @application_2, pet: @pet_3)
  end
  describe 'admin shelter index' do
    it 'shows all shelters in reverse alphabetical order.' do
      visit '/admin/shelters'

      within('div#list') do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_3.name)
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end
    end
    it 'shows shelters with pending applications' do
      visit '/admin/shelters'

      within('div#apps') do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).to_not have_content(@shelter_3.name)
      end
    end
  end
end
