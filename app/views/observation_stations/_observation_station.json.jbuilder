json.extract! observation_station, :id, :fmisid, :lpnn, :wmo, :name, :year, :lat, :lon, :elevation, :group, :created_at, :updated_at
json.url observation_station_url(observation_station, format: :json)
