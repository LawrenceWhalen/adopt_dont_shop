require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @pet_4 = @shelter_1.pets.create(name: 'Sam', breed: 'Persian', age: 2, adoptable: true)
    @application = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', status: 'Pending')
    @application_2 = Application.create(name: 'Master Dan', address_street: '555 Tamis crt.', address_city: 'Fryer', address_state: 'CO', address_zip: '80525', status: 'In Progress')
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
      expect(page).to have_content(@application.status)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
    end
  end
  describe 'add a pet to an application' do
    it 'when given a part of an existing dog name it returns full name case insesitive' do
      visit "/applications/#{@application.id}"

      expect(page).to have_button('Submit')
      expect(page).to_not have_content(@pet_4.name)

      fill_in 'Pet Name', with: 'sa'

      click_button('Submit')

      expect(page).to have_current_path("/applications/#{@application.id}", ignore_query: true)
      within('div#search') do
        expect(page).to have_content(@pet_4.name)
      end
    end
    it 'when a dog is searched it can be added to the application' do
      visit "/applications/#{@application.id}"

      fill_in 'Pet Name', with: 'Sa'

      click_button('Submit')

      within('div#search') do
        expect(page).to have_button('Adopt this Pet')
      end

      click_button('Adopt this Pet')

      expect(page).to have_current_path("/applications/#{@application.id}", ignore_query: true)
      within('div#pet_list') do
        expect(page).to have_content(@pet_4.name)
      end
    end
    it 'when a dog already on an application it cannot be added again' do
      visit "/applications/#{@application.id}"

      fill_in 'Pet Name', with: 'Sa'
      click_button('Submit')
      click_button('Adopt this Pet')

      fill_in 'Pet Name', with: 'Sa'
      click_button('Submit')
      click_button('Adopt this Pet')

      expect(page).to have_content("Error: Pet has already been taken")

      within('div#pet_list') do
        expect(page).to have_content(@pet_4.name, count: 1)
      end
    end
  end
  describe 'submitting an application' do
    it 'can only submit once pets are added' do
      visit "/applications/#{@application_2.id}"

      expect(page).to_not have_button('Submit Application')
      expect(page).to_not have_field('Describe why you would make a good pet parent:')

      fill_in 'Pet Name', with: 'Sa'
      click_button('Submit')
      click_button('Adopt this Pet')

      expect(page).to have_button('Submit Application')
      expect(page).to have_field('Describe why you would make a good pet parent:')
    end
    it 'submiting removes the ability to add pets and sets it to Pending' do
      visit "/applications/#{@application_2.id}"
      fill_in 'Pet Name', with: 'Sa'
      click_button('Submit')
      click_button('Adopt this Pet')

      fill_in 'Describe why you would make a good pet parent:', with: 'I love kitties!'
      click_button('Submit Application')

      expect(page).to have_current_path("/applications/#{@application_2.id}", ignore_query: true)
      expect(page).to_not have_button('Submit Application')
      expect(page).to_not have_button('Submit')
      expect(page).to have_content('Pending')
      expect(page).to have_content('I love kitties!')
    end
    it 'submiting without a description resets with an error' do
      visit "/applications/#{@application_2.id}"
      fill_in 'Pet Name', with: 'Sa'
      click_button('Submit')
      click_button('Adopt this Pet')

      click_button('Submit Application')

      expect(page).to have_current_path("/applications/#{@application_2.id}", ignore_query: true)
      expect(page).to have_button('Submit Application')
      expect(page).to have_button('Submit')
      expect(page).to have_content('In Progress')
      expect(page).to have_content("Error: Description can't be blank")
    end
  end
end
