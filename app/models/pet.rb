class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def app_status(app_id)
    ApplicationPet.where(pet_id: self.id, application_id: app_id).pluck(:pet_status)[0]
  end

  def app_join_id(app_id)
    ApplicationPet.where(pet_id: self.id, application_id: app_id).pluck(:id)[0]
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.pet_search(name_part)
    where("lower(name) LIKE ?", "%#{name_part.downcase}%")
  end

end
