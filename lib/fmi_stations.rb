class FmiStations
  require 'nokogiri'
  require 'open-uri'

  #Fetch all observation stations
  def self.fetch_stations
    #Time format (format: 2017-03-27T16:00:00Z)
    #time = Time.new
    #current_time = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&bbox=18,58,33,71&starttime=#{local_day_starts_at}&timestep=60&parameters=temperature"

    # Using nokogiri to fetch xml data
    response = Nokogiri::XML(open(url))

    # Parsing station info from xml
    response.xpath('//target:Location').each do |element|
      fmiid = element.xpath('gml:identifier').text
      name = element.xpath('gml:name')[0].children.text
      geoid = element.xpath('gml:name')[1].children.text
      wmo = element.xpath('gml:name')[2].children.text
      city = element.xpath('target:region').text
      if not ObservationStation.where(name: name).exists?
        ObservationStation.create(id:fmiid, wmo:wmo, name:name)
      end
    end

    # Parse lat lon info from xml
    response.xpath('//gml:Point').each do |element|
      stationName = element.xpath('gml:name').text
      latlon = element.xpath('gml:pos').text
      lat = latlon.split.first
      lon = latlon.split.second
      station = ObservationStation.find_by name: stationName
      if (!station.nil?)
        station.update(lat: lat, lon: lon)
        station.save
      end
    end

  end

  def self.fmi_key
    raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
    ENV['FMI_APIKEY']
  end
end
