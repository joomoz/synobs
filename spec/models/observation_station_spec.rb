require 'rails_helper'

RSpec.describe ObservationStation, type: :model do
  it "has the id set correctly" do
    station = ObservationStation.new id:10000

    expect(station.id).to eq(10000)
  end

  it "has the name set correctly" do
    station = ObservationStation.new name:"Helsinki-Vantaa"

    expect(station.name).to eq("Helsinki-Vantaa")
  end

  it "is not saved without a observation station name" do
    station = ObservationStation.new name:"Helsinki-Vantaa"

    expect(station).not_to be_valid
    expect(ObservationStation.count).to eq(0)
  end

  it "is not saved without a observation station id" do
    station = ObservationStation.new id:12345

    expect(station).not_to be_valid
    expect(ObservationStation.count).to eq(0)
  end

  describe "with a proper observation station id and name" do
    let(:observation_station){ ObservationStation.create id:10000, name:"Helsinki-Vantaa"}

    it "is saved" do
      expect(observation_station).to be_valid
      expect(ObservationStation.count).to eq(1)
    end
  end
end
