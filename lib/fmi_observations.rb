class FmiObservations
  require 'nokogiri'
  require 'open-uri'

  #Fetch observations
  def self.fetch_observations(id)

    #Beginning of day
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    param = 'temperature'
    timestep = 10 #minutes

    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{id}&starttime=#{local_day_starts_at}&timestep=#{timestep}&parameters=#{param}"

    # Using nokogiri to fetch xml data
    #response = Nokogiri::XML(open(url))

    # Parsing observation info from xml
    # Calculate number of available parameters
    #n = response.xpath("count(//wfs:member)");
    #i = 0

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

    # response.xpath('//wml2:MeasurementTimeseries').each do |element|
    #   parameter = element.xpath('//wml2:MeasurementTimeseries/@gml:id')[0].text
    #   parameter = parameter.split("-").last
      #JATKA TÄSTÄ!
      #if not Observation.where(fmisid: fmisid ).exists?
      #  Observation.create(fmisid:fmisid)
      #end
    #end

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
