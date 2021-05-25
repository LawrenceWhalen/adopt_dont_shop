# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
@application = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', description: 'loves animals', status: 'Pending')
ApplicationPet.create(application: @application, pet: @pet_1)
ApplicationPet.create(application: @application, pet: @pet_2)
ApplicationPet.create(application: @application, pet: @pet_3)
