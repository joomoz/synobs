class FmiObservations
  require 'nokogiri'
  require 'open-uri'

  #Fetch observations
  def self.fetch_observations(fmisid)

    #Beginning of day
    time = Date.today.to_time.beginning_of_day.utc
    local_day_starts_at = "#{time.strftime("%Y-%m-%d")}T#{time.utc.strftime("%H")}:00:00Z"
    #url = "http://data.fmi.fi/fmi-apikey/#{fmi_key}/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=#{fmisid}&starttime=#{local_day_starts_at}"
    url = "http://data.fmi.fi/fmi-apikey/8bc96ff0-03ea-43e3-bf12-256acfeaf5d4/wfs?request=getFeature&storedquery_id=fmi::observations::weather::timevaluepair&fmisid=100949&starttime=2017-04-19T16:40:00Z"
    # Using nokogiri to fetch xml data
    response = Nokogiri::XML(open(url))

    # Parsing observation info from xml
    # Calculate number of available parameters
    #n = response.xpath("count(//wfs:member)");
    #i = 0
    response.xpath('//wml2:MeasurementTimeseries').each do |element|
      parameter = element.xpath('//wml2:MeasurementTimeseries/@gml:id')[0].text
      parameter = parameter.split("-").last
      #JATKA TÄSTÄ!
      #if not Observation.where(fmisid: fmisid ).exists?
      #  Observation.create(fmisid:fmisid)
      #end

    end

  end

  def self.fmi_key
    raise "FMI_APIKEY env variable not defined" if not ENV['FMI_APIKEY']
    ENV['FMI_APIKEY']
  end
end
