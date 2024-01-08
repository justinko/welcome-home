class Resident < ApplicationRecord
  belongs_to :unit

  validates :name, presence: true
end
