class Unit < ApplicationRecord
  has_many :residents

  enum :floor_plan, [:studio, :suite], validate: true

  validates :number, presence: true, uniqueness: true

  def self.rent_roll(date = Time.current.to_date.to_fs(:db))
    join = <<~SQL
      LEFT OUTER JOIN residents ON residents.id = (
        SELECT id FROM residents
        WHERE residents.unit_id = units.id AND (
          residents.move_in IS NULL OR COALESCE(residents.move_out, '9999-12-31') > '#{date}'
        )
        ORDER BY residents.move_in ASC LIMIT 1
      )
    SQL
    order(:number).joins(join).select(
      :number,
      :floor_plan,
      "residents.name AS resident_name",
      "IIF(COALESCE(residents.move_in, 0) <= '#{date}', 'current', 'future') AS resident_status",
      :move_in,
      :move_out
    )
  end
end
