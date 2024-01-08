class Unit < ApplicationRecord
  has_many :residents

  enum :floor_plan, [:studio, :suite], validate: true

  validates :number, presence: true, uniqueness: true
end
