class CreateDailyObservations < ActiveRecord::Migration
  def change
    create_table :daily_observations do |t|
      t.integer :observation_station_id
      t.date :date
      t.float :t2max
      t.datetime :t2maxtime
      t.float :t2min
      t.datetime :t2mintime

      t.timestamps null: false
    end
  end
end
