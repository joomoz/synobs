class FmiObservations
  require 'nokogiri'
  require 'open-uri'

  #Fetch temperature observations
  def self.fetch_observations(id)

    #Beginning of day
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    param = 'temperature'
    timestep = 10 #minutes

    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{id}&starttime=#{local_day_starts_at}&timestep=#{timestep}&parameters=#{param}"

    response = HTTParty.get url
    observations = response.parsed_response["FeatureCollection"]["member"]["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"]

    # Save temperature observations
    observations.map do | obs |
      time = obs["MeasurementTVP"]["time"] #2017-03-27T16:00:00Z
      time = convertMetTimeToDateTime(time)
      value = obs["MeasurementTVP"]["value"]
      if (Observation.find_by time: time, observation_station_id: id).nil?
        Observation.create(observation_station_id:id, time: time, t2m: value)
      end
    end
  end

  #Fetch all observations for one obseravation station
  def self.fetch_all_observations(id)

    #Beginning of day
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    timestep = 10 #minutes

    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{id}&starttime=#{local_day_starts_at}&timestep=#{timestep}"

    response = HTTParty.get url
    observations = response.parsed_response["FeatureCollection"]["member"]
    fmisid = observations[0]["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["identifier"].first[1]

    # Save observations in a 2D hash
    obsHash = Hash.new()
    obsHash[time] = Hash.new()
    observations.map do | obs |
      #fmisid = obs["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["identifier"].first[1]
      parameter = obs["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["id"].split("-").last
      measurements = obs["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"]
      n = 0
      measurements.map do | measurement |
        value = measurement["MeasurementTVP"]["value"]
        time = measurement["MeasurementTVP"]["time"]
        time = convertMetTimeToDateTime(time)
        obsHash[time][parameter] = Hash.new()
        obsHash[time][parameter][n] = value
        # if (Observation.find_by time: time, observation_station_id: fmisid).nil?
        #    Observation.create(observation_station_id:id, time: time, t2m: value)
        # end
      end

    end
    binding.pry

  end


  def self.fmi_key
    raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
    ENV['FMI_APIKEY']
  end

  def self.convertMetTimeToDateTime(metTime)
    # MetTime (2017-03-27T16:00:00Z)
    time = metTime.split(/\D/)
    time = Time.new(time[0], time[1], time[2], time[3], time[4], time[5], "+00:00")
  end

end
