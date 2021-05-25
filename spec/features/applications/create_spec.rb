require 'rails_helper'

RSpec.describe 'application creation' do

  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip Code')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application and redirects to the application show page' do
        visit "/applications/new"

        fill_in 'Name', with: 'Tom Hardly'
        fill_in 'Street Address', with: 'Bumblebee Dr.'
        fill_in 'City', with: 'Fort Collins'
        fill_in 'State', with: 'CO'
        fill_in 'Zip Code', with: '80526'
        fill_in 'Description', with: 'loves animals'
        click_button 'Submit'
        application = Application.last

        expect(page).to have_current_path("/applications/#{application.id}")
        expect(page).to have_content('Tom Hardly')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        click_button 'Submit'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Address street can't be blank, Address city can't be blank, Address state can't be blank, Address state is the wrong length (should be 2 characters), Address zip can't be blank, Address zip is not a number, Address zip is the wrong length (should be 5 characters), Description can't be blank")
      end
    end
  end
end
