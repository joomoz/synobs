class FmiObservations
  require 'open-uri'
  #Fetch all observations for one obseravation station
  # def self.fetch_all_observations(id)
  #   #Beginning of day
  #   time = Date.today.to_time.beginning_of_day.utc
  #   local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
  #   timestep = 10 #minutes
  #
  #   url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{id}&starttime=#{local_day_starts_at}&timestep=#{timestep}"
  #   response = HTTParty.get url
  #   observations = response.parsed_response["FeatureCollection"]["member"]
  #   fmisid = observations[0]["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["identifier"].first[1]
  #
  #   obsHash = Hash.new()
  #   obsHash = saveObservationsToHash(observations, obsHash)
  #   saveObservationsToDB(obsHash, fmisid)
  # end

  # def self.fetch_observations_from_all_stations
  #   time = Date.today.to_time.beginning_of_day.utc
  #   local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
  #   timestep = 10 #minutes
  #   #start = Time.now
  #   url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=18,58,33,71&starttime=#{local_day_starts_at}&timestep=#{timestep}&parameters=temperature"
  #   response = HTTParty.get url
  #   observations = response.parsed_response["FeatureCollection"]["member"]
  #   # finish = Time.now
  #   # diff = finish - start
  #   saveAllObservationsToDB(observations)
  # end

  def self.fetch_daily_temperatures_from_all_stations
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    timestep = 1 #minutes
    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=18,58,33,71&starttime=#{local_day_starts_at}&timestep=#{timestep}&parameters=temperature"
    response = HTTParty.get url
    observations = response.parsed_response["FeatureCollection"]["member"]
    #binding.pry
    saveDailyTemperaturesToDB(observations)
  end

  private

    def self.saveDailyTemperaturesToDB(observations)
      observations.each do |station|
        fmisid = station["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["identifier"].first[1]
        measurements = station["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"]
        max = -999.9
        min = 999.9
        maxTime = convertMetTimeToDateTime(station["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"].first["MeasurementTVP"]["time"])
        minTime = maxTime
        measurements.each do |obs|
          value = obs["MeasurementTVP"]["value"].to_f
          time = obs["MeasurementTVP"]["time"]
          time = convertMetTimeToDateTime(time)
          if (value > max)
            max = value
            maxTime = time
          end
          if (value < min)
            min = value
            minTime = time
          end
        end

        if (station = DailyObservation.find_by date: Date.today, observation_station_id: fmisid).nil?
          DailyObservation.create(observation_station_id: fmisid, date: Date.today,
            t2max: max, t2maxtime: maxTime, t2min: min, t2mintime: minTime)
        else
          if station.t2max < max
            station.update(t2max: max, t2maxtime: maxTime)
          end
          if station.t2min > min
            station.update(t2min: min, t2mintime: minTime)
          end
        end
      end
    end

    # Save observations into a hash
    # def self.saveObservationsToHash(observations, obsHash)
    #   observations.map do | obs |
    #     fmisid = obs["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["identifier"].first[1]
    #     param = obs["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["id"].split("-").last
    #     measurements = obs["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"]
    #     n = 0
    #     obsHash[param] = Hash.new()
    #     measurements.map do | measurement |
    #       value = measurement["MeasurementTVP"]["value"]
    #       time = measurement["MeasurementTVP"]["time"]
    #       time = convertMetTimeToDateTime(time)
    #       obsHash[param][time] = Hash.new()
    #       obsHash[param][time] = value
    #     end
    #   end
    #   obsHash
    # end

    # Save all observations to db
    # def self.saveAllObservationsToDB(observations)
    #   observations.each do |station|
    #     fmisid = station["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["identifier"].first[1]
    #     measurements = station["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"]
    #     measurements.each do |obs|
    #       value = obs["MeasurementTVP"]["value"]
    #       time = obs["MeasurementTVP"]["time"]
    #       time = convertMetTimeToDateTime(time)
    #       if (Observation.find_by time: time, observation_station_id: fmisid).nil?
    #         Observation.create(observation_station_id: fmisid, time: time, t2m: value)
    #       end
    #     end
    #   end
    # end

    # Save observations to db using time from one parameter
    # def self.saveObservationsToDB(obsHash, fmisid)
    #   obsHash[obsHash.keys.first].each do |element|
    #     time = element[0]
    #     if (Observation.find_by time: time, observation_station_id: fmisid).nil?
    #        Observation.create(observation_station_id: fmisid, time: time, t2m: obsHash['t2m'][time],
    #          ws_10min: obsHash['ws_10min'][time] ,wg_10min: obsHash['wg_10min'][time],
    #          wd_10min: obsHash['wd_10min'][time] ,rh: obsHash['rh'][time],
    #          td: obsHash['td'][time] ,r_1h: obsHash['r_1h'][time],
    #          ri_10min: obsHash['ri_10min'][time] ,snow_aws: obsHash['snow_aws'][time],
    #          p_sea: obsHash['p_sea'][time], vis: obsHash['vis'][time],
    #          n: obsHash['n_man'][time], wawa: obsHash['wawa'][time])
    #     end
    #   end
    # end

    def self.convertMetTimeToDateTime(metTime)
      time = metTime.split(/\D/) # MetTime (2017-03-27T16:00:00Z)
      time = Time.new(time[0], time[1], time[2], time[3], time[4], time[5], "+00:00")
    end

    def self.fmi_key
      raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
      ENV['FMI_APIKEY']
    end
end
