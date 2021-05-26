# app/models/application_pets.rb

class ApplicationPet < ApplicationRecord
  validates :pet, presence: true, uniqueness: { scope: :application }
  validates :application, presence: true
  belongs_to :application
  belongs_to :pet
end
