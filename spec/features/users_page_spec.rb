require 'rails_helper'

describe "User" do
  before :each do
    user = FactoryGirl.create :user
  end

  describe "who has signed up" do

    it "can signin with right credentials" do
      visit signin_path
      fill_in('username', with:'John')
      fill_in('password', with:'Pass1')
      click_button('Sign in')
      #save_and_open_page

      expect(page).to have_content 'John'
      expect(page).to have_content 'Welcome John'
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      fill_in('username', with:'John')
      fill_in('password', with:'wrong')
      click_button('Sign in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password incorrect'
    end

  end

  describe "who has signed in" do
    before :each do
      visit signin_path
      fill_in('username', with:'John')
      fill_in('password', with:'Pass1')
      click_button('Sign in')
      click_link('My page')
    end

    it "can remove his/hers account" do

      expect{
        click_link('Delete your user account')
      }.to change{User.count}.by(-1)
      expect(page).to have_content 'User was successfully destroyed'
    end

    it "can modify his/hers password" do
      click_link('Change password')
      fill_in('user_password', with:'AnotherPass1')
      fill_in('user_password_confirmation', with:'AnotherPass1')
      click_button('Update User')

      expect(page).to have_content 'User was successfully updated'
    end

    it "cannot modify password with insufficient details" do
      click_link('Change password')
      fill_in('user_password', with:'wrong')
      fill_in('user_password_confirmation', with:'wrong')
      click_button('Update User')

      expect(page).to have_content 'error'
    end

    it "can add observation station as a favourite station" do
      station = FactoryGirl.create(:observation_station)
      click_link "Observation stations"
      click_link "Station"

      expect{
        click_button('Add as favourite station')
      }.to change{FavouriteStation.count}.by(1)
    end

    it "can sign out" do
      click_link "Sign out"

      expect(current_path).to eq(root_path)
    end

  end

  describe "who has not yet signed up" do

    it "when signed up with good credentials, user is added to the system" do
      visit signup_path
      fill_in('user_username', with:'Mike')
      fill_in('user_password', with:'Secret66')
      fill_in('user_password_confirmation', with:'Secret66')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end

    it "cannot sign up with bad credentials" do
      visit signup_path
      fill_in('user_username', with:'Mike')
      fill_in('user_password', with:'pass')
      fill_in('user_password_confirmation', with:'pass')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(0)
      expect(page).to have_content 'error'
    end
  end

end
