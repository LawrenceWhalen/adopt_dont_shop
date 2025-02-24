# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all
ApplicationPet.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
@pet_4 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

@application_1 = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', description: 'loves animals', status: 'Pending')
@application_2 = Application.create(name: 'Master Dan', address_street: '555 Tamis crt.', address_city: 'Fryer', address_state: 'CO', address_zip: '80525', status: 'In Progress')

ApplicationPet.create(application: @application_1, pet: @pet_1)
ApplicationPet.create(application: @application_1, pet: @pet_2)
ApplicationPet.create(application: @application_1, pet: @pet_3)
ApplicationPet.create(application: @application_2, pet: @pet_1)
ApplicationPet.create(application: @application_2, pet: @pet_4)
