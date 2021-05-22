# spec/models/application_spec.rb

require "rails_helper"

RSpec.describe Application, type: :model do
  describe "applications" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end
end
