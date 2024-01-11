class InitialMigration < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.integer :number, null: false, index: {unique: true}
      t.integer :floor_plan, null: false
      t.timestamps
    end

    create_table :residents do |t|
      t.references :unit, null: false, foreign_key: true
      t.string :name, null: false
      t.date :move_in, :move_out
      t.timestamps
    end
  end
end
