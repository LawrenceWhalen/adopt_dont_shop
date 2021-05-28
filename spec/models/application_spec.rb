# spec/models/application_spec.rb

require "rails_helper"

RSpec.describe Application, type: :model do
  describe "applications" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address_street) }
    it { should validate_presence_of(:address_city) }
    it { should validate_presence_of(:address_state) }
    it { should validate_presence_of(:address_zip) }
    it { should validate_presence_of(:description).on(:update) }
    it { should validate_length_of(:address_state).is_equal_to(2) }
    it { should validate_length_of(:address_zip).is_equal_to(5) }
  end

  describe 'class methods' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @application = Application.create(name: 'Andy Dude', address_street: '555 Mag dr.', address_city: 'Lovit', address_state: 'CO', address_zip: '80555', status: 'Pending')
    end
    describe '.approval_check' do
      it 'returns approved if all pets have been approved' do
        ApplicationPet.create(application: @application, pet: @pet_1, pet_status: 'Approved')
        ApplicationPet.create(application: @application, pet: @pet_2, pet_status: 'Approved')

        expect(@application.approval_check).to eq('Approved')
      end
      it 'returns Rejected if a pet has been rejected' do
        ApplicationPet.create(application: @application, pet: @pet_1, pet_status: 'Approved')
        ApplicationPet.create(application: @application, pet: @pet_2, pet_status: 'Rejected')

        expect(@application.approval_check).to eq('Rejected')
      end
      it 'returns nil if all pets have not been selected' do
        ApplicationPet.create(application: @application, pet: @pet_1)
        ApplicationPet.create(application: @application, pet: @pet_2, pet_status: 'Approved')

        expect(@application.approval_check).to eq(nil)
      end
    end
    describe '.adopt_pets' do
      it 'returns approved if all pets have been approved' do
        ApplicationPet.create(application: @application, pet: @pet_1, pet_status: 'Approved')
        ApplicationPet.create(application: @application, pet: @pet_2, pet_status: 'Approved')

        expect(@application.adopt_pets).to eq(2)
      end
    end
  end
end
