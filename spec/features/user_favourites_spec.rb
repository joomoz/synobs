require 'rails_helper'

describe "User" do
  let!(:user) { FactoryGirl.create :user }
  let!(:observation_station) { FactoryGirl.create :observation_station, name:"Helsinki" }

  before :each do
    visit signin_path
    fill_in('username', with:'John')
    fill_in('password', with:'Pass1')
    click_button('Sign in')
  end

  it "can add station as a favourite station" do
    click_link "Helsinki"

    expect{
      click_button('Add as favourite station')
    }.to change{FavouriteStation.count}.by(1)
    expect(user.favourites.count).to eq(1)
    expect(page).to have_content "has been added to the favourites"
  end

  it "can remove station from a favourite stations" do
    click_link "Helsinki"
    click_button('Add as favourite station')

    expect{
      click_button('Remove from favourite stations')
    }.to change{FavouriteStation.count}.by(-1)
    expect(user.favourites.count).to eq(0)
    expect(page).to have_content "has been removed from the favourites"
  end


end
