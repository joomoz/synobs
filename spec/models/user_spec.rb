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
    let(:user){ User.create username:"John", password:"Passw1", password_confirmation:"Passw1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  end

end
