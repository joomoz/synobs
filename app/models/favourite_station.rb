class FavouriteStation < ActiveRecord::Base
  belongs_to :user
  belongs_to :observation_station
  
end
