class CreateObservationStations < ActiveRecord::Migration
  def change
    create_table :observation_stations do |t|
      t.integer :fmisid
      t.integer :lpnn
      t.integer :wmo
      t.string :name
      t.integer :year
      t.float :lat
      t.float :lon
      t.integer :elevation
      t.string :group

      t.timestamps null: false
    end
  end
end
