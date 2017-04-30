require 'rails_helper'

RSpec.describe FavouriteStation, type: :model do
  it "has the user id set correctly" do
    fav_station = FavouriteStation.new user_id:9

    expect(fav_station.user_id).to eq(9)
  end

  it "has the observation station id set correctly" do
    fav_station = FavouriteStation.new observation_station_id:26

    expect(fav_station.observation_station_id).to eq(26)
  end

  it "is not saved without an observation station id" do
    fav_station = FavouriteStation.new user_id:9

    expect(fav_station).not_to be_valid
    expect(FavouriteStation.count).to eq(0)
  end

  it "is not saved without a user id" do
    fav_station = FavouriteStation.new observation_station_id:26

    expect(fav_station).not_to be_valid
    expect(FavouriteStation.count).to eq(0)
  end

  describe "with a proper user id and observation station id" do
    let(:favourite_station){ FavouriteStation.create user_id:9, observation_station_id:65 }

    it "is saved" do
      expect(favourite_station).to be_valid
      expect(FavouriteStation.count).to eq(1)
    end
  end
end
