namespace :welcome_home do
  desc "Idempotently load data into the database"
  task load_data: :environment do
    require "csv"

    CSV.foreach(Rails.root.join("units-and-residents.csv"), headers: true) do |row|
      unit = Unit.find_or_create_by!(number: row["unit"]) { _1.floor_plan = row["floor_plan"].downcase }

      if resident_name = row["resident"]
        unit.residents.find_or_create_by!(name: resident_name) do |resident|
          resident.move_in = Time.zone.strptime(row["move_in"], "%m/%d/%Y") if row["move_in"]
          resident.move_out = Time.zone.strptime(row["move_out"], "%m/%d/%Y") if row["move_out"]
        end
      end
    end
  end
end
