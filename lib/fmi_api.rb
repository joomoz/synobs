class FmiApi

  def self.fetch_stations
    #Fetch all stations using current time
    current_time =
    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=20,59,31,71&parameters=temperature&starttime=2017-03-25T15:30:00Z"



    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.fmi_key
    raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
    ENV['FMI_APIKEY']
  end
end
