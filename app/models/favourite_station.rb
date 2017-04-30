class FavouriteStation < ActiveRecord::Base
  belongs_to :user
  belongs_to :observation_station

  validates :observation_station_id, presence: true
  validates :user_id, presence: true

end
