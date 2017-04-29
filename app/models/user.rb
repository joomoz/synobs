class User < ActiveRecord::Base

  has_many :favourite_stations, dependent: :destroy
  has_many :favourites, through: :favourite_stations, source: :observation_station

  has_secure_password

  validates :username, uniqueness: true,
                        length: { minimum: 4, maximum: 30 }

  validates :password, length: { minimum: 4},
                       format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
                         message: "has to have at least one number and one capital letter"}

end
