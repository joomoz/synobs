require 'rails_helper'

describe "Observations page" do
  it "should show observations index page" do
    visit observations_path

    expect(page).to have_content 'Observations'
  end

  describe "when predefined observations are created" do
    let!(:observation_station) { FactoryGirl.create :observation_station, name:"Helsinki", id:12345 }
    let!(:observation) { FactoryGirl.create :observation, observation_station_id:observation_station.id }
    before :each do
      visit observations_path
    end

    # it "lists the existing observations" do
    #   expect(page).to have_content observation.observation_station_id
    # end

    # it "allows user to navigate to a observation's page" do
    #   page.click_link('', :href => "/observations/#{observation.id}")
    #
    #   expect(page).to have_content "Helsinki"
    # end

  end

end
