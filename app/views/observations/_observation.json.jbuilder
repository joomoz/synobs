json.extract! observation, :id, :fmisid, :time, :t2m, :td, :ws_10min, :wg_10min, :wd_10min, :rh, :r_1h, :ri_10min, :snow_aws, :p_sea, :vis, :n, :wawa, :created_at, :updated_at
json.url observation_url(observation, format: :json)
