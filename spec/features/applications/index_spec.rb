require 'rails_helper'

# RSpec.describe 'the applications index' do
#   it 'lists all the pets with their attributes' do
#     shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
#     pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
#     application = Application.create(name: 'Joshua Smith', address: '' description: 'I really love puppies.', pet_ids: [pet_1.id, pet_2id], status: 'In Progress')
#
#     visit '/applications'
#
#     expect(page).to have_content(application.name)
#     expect(page).to have_content(application.description)
#     expect(page).to have_content(application.pet_ids)
#     expect(page).to have_content(application.status)
#   end
# end
