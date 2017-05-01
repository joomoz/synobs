require 'rails_helper'

describe "Observation stations page" do
  it "should show observation stations index page" do
    visit observation_stations_path
    #save_and_open_page

    expect(page).to have_content 'Observation Stations'
    expect(page).to have_content 'Number of stations:'
  end

  describe "when predefined observation stations are created" do
    before :each do
      stations = ["Helsinki", "Vantaa", "Rovaniemi"]
      stations.each do |station|
        FactoryGirl.create(:observation_station, name: station)
      end
      visit observation_stations_path
    end

    it "lists the existing observation stations" do
      stations = ["Helsinki", "Vantaa", "Rovaniemi"]
      stations.each do |station_name|
        expect(page).to have_content station_name
      end
    end

    it "allows user to navigate to a observation station page" do
      click_link "Helsinki"

      expect(page).to have_content "Helsinki"
      expect(page).to have_content "Station doesn't have any observations"
    end

  end

end
