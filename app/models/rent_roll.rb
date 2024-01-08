class RentRoll
  def initialize(date = Time.current.to_date.to_fs(:db))
    @date = date
  end

  def report
    Tabulo::Table.new(units, :number, :floor_plan, :resident_name, :resident_status, :move_in, :move_out).pack
  end

  def units
    join = <<~SQL
      LEFT OUTER JOIN residents ON residents.id = (
        SELECT id FROM residents
        WHERE residents.unit_id = units.id AND (
          residents.move_in IS NULL OR COALESCE(residents.move_out, '9999-12-31') > '#{@date}'
        )
        ORDER BY residents.move_in ASC LIMIT 1
      )
    SQL
    Unit.order(:number).joins(join).select(
      :number,
      :floor_plan,
      "residents.name AS resident_name",
      "IIF(
        residents.move_in IS NULL,
        NULL,
        IIF(
          residents.move_in <= '#{@date}', '#{I18n.t("current")}', '#{I18n.t("future")}'
        )
      ) AS resident_status",
      :move_in,
      :move_out
    )
  end
end
