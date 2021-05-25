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
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:address_state).is_equal_to(2) }
    it { should validate_length_of(:address_zip).is_equal_to(5) }
  end
end
