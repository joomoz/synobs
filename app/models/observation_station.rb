class ObservationStation < ActiveRecord::Base
  has_many :observations, dependent: :destroy
  has_many :daily_observations, dependent: :destroy
  has_many :favourite_stations
  has_many :users, through: :favourite_stations, dependent: :destroy

  validates :id, uniqueness: true, presence: true
  validates :name, presence: true

  def to_s
    "#{name}"
  end

end
