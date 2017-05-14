require 'rails_helper'

describe "Favourite station" do
  let!(:user) { FactoryGirl.create :user }
  let!(:observation_station) { FactoryGirl.create :observation_station, name:"Helsinki" }

  describe "for user that is signed in" do
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

    it "can be removed" do
      visit new_favourite_station_path
      click_button('Create Favourite station')
      click_link 'My page'
      click_link 'Helsinki'

      expect{
        click_button('Remove from favourite stations')
      }.to change{FavouriteStation.count}.by(-1)
      expect(page).to have_content "has been removed from the favourites"
    end
  end

  describe "for user that is not signed in" do
    it "cannot be added" do
      visit new_favourite_station_path

      expect(user.favourites.count).to eq(0)
      expect(current_path).to eq(signin_path)
      expect(page).to have_content "You have to be signed in"
    end
  end
end
