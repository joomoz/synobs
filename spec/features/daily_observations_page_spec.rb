require 'rails_helper'

describe "Daily Observations page" do
  it "should show observations index page" do
    visit daily_observations_path

    expect(page).to have_content 'Daily Observations'
  end

  describe "when predefined observations are created" do
    let!(:observation_station) { FactoryGirl.create :observation_station, name:"Helsinki", id:12345 }
    let!(:daily_observation) { FactoryGirl.create :daily_observation, observation_station_id:observation_station.id }
    before :each do
      visit daily_observations_path
    end

    it "lists the existing observations" do
      expect(page).to have_content daily_observation.observation_station.name
    end

    it "lists temperatures" do
      expect(page).to have_content daily_observation.t2max
      expect(page).to have_content daily_observation.t2min
    end

  end

end
