class FmiObservations
  require 'nokogiri'
  require 'open-uri'

  #Fetch observations
  def self.fetch_observations(fmisid)

    #Beginning of day
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{fmisid}&starttime=#{local_day_starts_at}"

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

  def self.fmi_key
    raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
    ENV['FMI_APIKEY']
  end
end
