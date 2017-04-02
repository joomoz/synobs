class FmiApi
  require 'nokogiri'
  require 'open-uri'

  #Fetch all stations using current time (format: 2017-03-27T16:00:00Z)
  def self.fetch_stations

    time = Time.new
    current_time = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=20,59,31,71&starttime=#{current_time}&parameters=temperature"

    # Using nokogiri to fetch xml data
    response = Nokogiri::XML(open(url))

    # Parsing station info from xml
    response.xpath('//target:Location').each do |element|
      puts element.text
      fmiid = element.xpath('gml:identifier').text
      name = element.xpath('gml:name')[0].children.text
      geoid = element.xpath('gml:name')[1].children.text
      wmo = element.xpath('gml:name')[2].children.text
      city = element.xpath('target:region').text
      if not ObservationStation.where(name: name).exists?
        ObservationStation.create(fmisid:fmiid, wmo:wmo, name:name)
      end
    end
  end

  # Test version
  def self.fetch_stations_v2
    #Fetch all stations using current time (format: 2017-03-27T16:00:00Z) (UTC time)
    time = Time.new
    current_time = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"

    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=22,59,27,61&starttime=#{current_time}&parameters=temperature"

    response = HTTParty.get "#{url}"
    return nil if response.code != 200

    #stations = response.parsed_response["FeatureCollection"]["member"]["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["name"]
    stations = response.parsed_response["FeatureCollection"]["member"]["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]

    #stations = [stations] if stations.is_a?(Hash)
    #Not yet working
    stations.each do | station |
      name = station[0].first[1]
      wmo = station[2].first[1]
      puts name
      puts wmo
      #:fmisid, :lpnn, :wmo, :name, :year, :lat, :lon, :elevation, :group
      ObservationStation.new(name:name, wmo:wmo)
    end
  end

  def self.fmi_key
    raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
    ENV['FMI_APIKEY']
  end
end
