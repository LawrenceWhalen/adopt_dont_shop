# app/models/application.rb

class Application < ApplicationRecord
  validates :name, presence: true
  validates :address_street, presence: true
  validates :address_city, presence: true
  validates :address_state, presence: true, length: { is: 2 }
  validates :address_zip, presence: true, numericality: true, length: { is: 5 }
  validates :description, presence: true
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
end
