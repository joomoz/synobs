class FmiObservations
  require 'nokogiri'
  require 'open-uri'

  #Fetch observations
  def self.fetch_observations(id)

    #Beginning of day
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    param = 'temperature'

    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{id}&starttime=#{local_day_starts_at}&parameters=#{param}"
    #url = "http://data.fmi.fi/fmi-apikey/8bc96ff0-03ea-43e3-bf12-256acfeaf5d4/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=100949&starttime=2017-05-10T12:00:00Z&parameters=temperature"

    # Using nokogiri to fetch xml data
    #response = Nokogiri::XML(open(url))

    # Parsing observation info from xml
    # Calculate number of available parameters
    #n = response.xpath("count(//wfs:member)");
    #i = 0

    response = HTTParty.get url

    observations = response.parsed_response["FeatureCollection"]["member"]["PointTimeSeriesObservation"]["result"]["MeasurementTimeseries"]["point"]

    # Save pbservations
    observations.map do | obs |
      t = obs["MeasurementTVP"]["time"] #2017-03-27T16:00:00Z
      t = t.split("-")
      #binding.pry
      time = Time.new(1993, 02, 24, 12, 0, 0, "+00:00")
      value = obs["MeasurementTVP"]["value"]
      #Observation.create(observation_station_id:id, time: time, t2m: value)
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
end
