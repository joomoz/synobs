json.extract! daily_observation, :id, :observation_station_id, :date, :t2max, :t2maxtime, :t2min, :t2mintime, :created_at, :updated_at
json.url daily_observation_url(daily_observation, format: :json)
