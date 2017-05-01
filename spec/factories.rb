FactoryGirl.define do
  factory :user do
    username "John"
    password "Pass1"
    password_confirmation "Pass1"
  end

  factory :observation_station do
    sequence(:id)
    name "Station"
    # sequence :observation_station do |n|
    #   id (10000 + n)
    #   name "Station#{n}"
    # end
  end

  factory :favourite_station do
    user_id 1
    observation_station_id 1
  end

  factory :observation do
    sequence(:id)
    observation_station_id 12345
  end

end
