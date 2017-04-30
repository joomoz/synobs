FactoryGirl.define do
  factory :user do
    username "John"
    password "Pass1"
    password_confirmation "Pass1"
  end

  factory :observation_station do
    id 99999
    name "Helsinki"
  end

  factory :favourite_station do
    user_id 1
    observation_station_id 1
  end

end
