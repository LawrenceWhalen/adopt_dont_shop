class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search_params)
    where("lower(name) ILIKE ?", "%#{search_params.downcase}%")
  end
end
