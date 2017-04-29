class CreateFavouriteStations < ActiveRecord::Migration
  def change
    create_table :favourite_stations do |t|
      t.integer :observation_station_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
