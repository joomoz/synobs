class ObservationStation < ActiveRecord::Base
  has_many :observations, dependent: :destroy
  has_many :favourite_stations
  has_many :users, through: :favourite_stations, dependent: :destroy

  def to_s
    "#{name} | Location: #{lat}, #{lon}"
  end

end
