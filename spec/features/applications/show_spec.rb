require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', description: 'loves animals', status: 'Pending')
    ApplicationPet.create(application: @application, pet: @pet_1)
    ApplicationPet.create(application: @application, pet: @pet_2)
    ApplicationPet.create(application: @application, pet: @pet_3)
  end
  describe 'visit a show page' do
    it 'should dispay the full application row' do

      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.address_street)
      expect(page).to have_content(@application.address_city)
      expect(page).to have_content(@application.address_state)
      expect(page).to have_content(@application.address_zip)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.status)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
    end

    it 'should contain links to the pets pages' end
  end
end
