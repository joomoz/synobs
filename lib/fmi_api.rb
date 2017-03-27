class FmiApi

  def self.fetch_stations
    #Fetch all stations using current time
    current_time =

    #url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=20,59,31,71&parameters=temperature&starttime=2017-03-27T15:00:00Z"
    # url = "http://data.fmi.fi/fmi-apikey/8bc96ff0-03ea-43e3-bf12-256acfeaf5d4/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=20,59,31,71&parameters=temperature&starttime=2017-03-27T15:00:00Z"
    url = "http://data.fmi.fi/fmi-apikey/8bc96ff0-03ea-43e3-bf12-256acfeaf5d4/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=100968&starttime=2017-03-27T16:15:00Z&parameters=temperature"

    #response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    #places = response.parsed_response["bmp_locations"]["location"]

    response = HTTParty.get "#{url}"
    return nil if response.code != 200

    stations = response.parsed_response["FeatureCollection"]["member"]["PointTimeSeriesObservation"]["featureOfInterest"]["SF_SpatialSamplingFeature"]["sampledFeature"]["LocationCollection"]["member"]["Location"]["name"]

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
