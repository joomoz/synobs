require 'rails_helper'

describe "Favourite station" do
  let!(:user) { FactoryGirl.create :user }
  let!(:observation_station) { FactoryGirl.create :observation_station, name:"Helsinki" }

  before :each do
    visit signin_path
    fill_in('username', with:'John')
    fill_in('password', with:'Pass1')
    click_button('Sign in')
  end

  it "can be added" do
    visit new_favourite_station_path

    expect{
      click_button('Create Favourite station')
    }.to change{FavouriteStation.count}.by(1)
    expect(user.favourites.count).to eq(1)
    expect(page).to have_content "has been added to the favourites"
  end

  it "multiple favourites can be added" do
    click_link 'John'
    add_multiple_favourite_stations(user, 3)

    expect(user.favourites.count).to eq(3)
  end

  it "20 favourites can be added" do
    click_link 'John'
    add_multiple_favourite_stations(user, 20)

    expect(user.favourites.count).to eq(20)
  end

  it "favourite can be removed" do
    add_favourite_station_for_user(user)
    click_link 'John'
    click_link 'Station'

    expect{
      click_button('Remove from favourite stations')
    }.to change{FavouriteStation.count}.by(-1)
    expect(page).to have_content "has been removed from the favourites"
  end

end


def add_favourite_station_for_user(user)
  station = FactoryGirl.create(:observation_station)
  fav_station = FactoryGirl.create(:favourite_station, user_id:user.id, observation_station_id:station.id)
  fav_station
end

def add_multiple_favourite_stations(user, n)
  for i in 1..n
   add_favourite_station_for_user(user)
  end
end
