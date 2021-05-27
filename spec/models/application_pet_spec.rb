# spec/models/application_pet_spec.rb
require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    # it { should validate_uniqueness_of(:pet).scoped_to(:application) }
    it { should validate_presence_of(:application) }
    it { should validate_presence_of(:pet) }
    it {should belong_to :application}
    it {should belong_to :pet}
  end
end
