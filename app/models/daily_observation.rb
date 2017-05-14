class DailyObservation < ActiveRecord::Base
  belongs_to :observation_station
  validates :observation_station_id, presence: true

  def to_s
    "Max: #{t2max}, min: #{t2min}"
  end
end
