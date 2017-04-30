require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username:"John"

    expect(user.username).to eq("John")
  end

  it "is not saved without a password" do
    user = User.create username:"John"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password"do
    user = User.create username:"John", password:"Pw1", password_confirmation:"Pw1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password that has only letters"do
    user = User.create username:"John", password:"Password", password_confirmation:"Password"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password that doesn't have capital letter"do
    user = User.create username:"John", password:"pass1", password_confirmation:"pass1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without username"do
    user = User.create password:"pass1", password_confirmation:"pass1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  end

  describe "favourite station" do
    let(:user){ FactoryGirl.create(:user) }
    let(:observation_station){ FactoryGirl.create(:observation_station) }

    it "count without any is 0" do
      expect(user.favourites.count).to eq(0)
    end

    it "is saved with a proper ids" do
      fav = FactoryGirl.create(:favourite_station, user_id:user.id, observation_station_id:observation_station.id)
      #create_favourite_station_with_observation_station(user, 98765)

      expect(user.favourites.count).to eq(1)
    end

    it "can have two favourites" do
      create_favourite_station_with_observation_station(user, 98765)
      create_favourite_station_with_observation_station(user, 23456)

      expect(user.favourites.count).to eq(2)
    end

    it "can have three favourites" do
      create_favourite_stations(user, 11111, 22222, 33333)

      expect(user.favourites.count).to eq(3)
    end

  end
end

def create_favourite_station_with_observation_station(user, observation_station_id)
  station = FactoryGirl.create(:observation_station, id:observation_station_id, name:"XXX")
  fav_station = FactoryGirl.create(:favourite_station, user_id:user.id, observation_station_id:station.id)

  fav_station
end

def create_favourite_stations(user, *observation_station_ids)
  observation_station_ids.each do |id|
    create_favourite_station_with_observation_station(user, id)
  end
end
