# app/models/application_pets.rb

class ApplicationPet < ApplicationRecord
  validates :pet, presence: true, uniqueness: { scope: :application_id }
  validates :application, presence: true
  validates :pet_status, presence: true, on: :update
  belongs_to :application
  belongs_to :pet
end
