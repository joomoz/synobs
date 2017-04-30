class Observation < ActiveRecord::Base
  belongs_to :observation_station

  validates :observation_station_id, presence: true

end
