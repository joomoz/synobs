require 'rails_helper'

RSpec.describe DailyObservation, type: :model do
  it "has the observation station id set correctly" do
    observation = DailyObservation.new observation_station_id: 10010

    expect(observation.observation_station_id).to eq(10010)
  end

  it "is not saved without a observation station id" do
    observation = Observation.new

    expect(observation).not_to be_valid
    expect(Observation.count).to eq(0)
  end

  describe "with a proper observation station id" do
    let(:observation){ Observation.create observation_station_id:10010 }

    it "is saved" do
      expect(observation).to be_valid
      expect(Observation.count).to eq(1)
    end
  end
end
