class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.integer :fmisid
      t.datetime :time
      t.float :t2m
      t.float :td
      t.float :ws_10min
      t.float :wg_10min
      t.float :wd_10min
      t.float :rh
      t.float :r_1h
      t.float :ri_10min
      t.float :snow_aws
      t.float :p_sea
      t.float :vis
      t.float :n
      t.float :wawa

      t.timestamps null: false
    end
  end
end
