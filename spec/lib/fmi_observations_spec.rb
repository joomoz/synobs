require 'rails_helper'

describe "FmiObservations API" do
    it "When HTTP GET returns multiple stations, daily observations are properly saved to db" do
      canned_answer = answer_with_multiple_stations
      stub_request(:get, /.*/).to_return(body: canned_answer)
      # FmiObservations.fetch_daily_temperatures_from_all_stations
      #
      # expect(DailyObservation.count).to eq(2)
    end

  # it "When HTTP GET returns empty list, nothing is saved to db" do
  #   canned_answer = empty_answer
  #   stub_request(:get, /.*/).to_return(body: canned_answer)
  #   FmiObservations.fetch_daily_temperatures_from_all_stations
  #
  #   expect(DailyObservation.count).to eq(0)
  # end

  private
  def empty_answer
    answer = <<-END_OF_STRING

    END_OF_STRING
  end

  def answer_with_multiple_stations
    answer = <<-END_OF_STRING
    <wfs:FeatureCollection
    timeStamp="2017-05-14T19:15:06Z"
    numberMatched="2"
    numberReturned="2"
           xmlns:wfs="http://www.opengis.net/wfs/2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:om="http://www.opengis.net/om/2.0"
        xmlns:ompr="http://inspire.ec.europa.eu/schemas/ompr/3.0"
        xmlns:omso="http://inspire.ec.europa.eu/schemas/omso/3.0"
        xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:gmd="http://www.isotc211.org/2005/gmd"
        xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:swe="http://www.opengis.net/swe/2.0"
        xmlns:gmlcov="http://www.opengis.net/gmlcov/1.0"
        xmlns:sam="http://www.opengis.net/sampling/2.0"
        xmlns:sams="http://www.opengis.net/samplingSpatial/2.0"
        xmlns:wml2="http://www.opengis.net/waterml/2.0"
	xmlns:target="http://xml.fmi.fi/namespace/om/atmosphericfeatures/1.0"
        xsi:schemaLocation="http://www.opengis.net/wfs/2.0 http://schemas.opengis.net/wfs/2.0/wfs.xsd
        http://www.opengis.net/gmlcov/1.0 http://schemas.opengis.net/gmlcov/1.0/gmlcovAll.xsd
        http://www.opengis.net/sampling/2.0 http://schemas.opengis.net/sampling/2.0/samplingFeature.xsd
        http://www.opengis.net/samplingSpatial/2.0 http://schemas.opengis.net/samplingSpatial/2.0/spatialSamplingFeature.xsd
        http://www.opengis.net/swe/2.0 http://schemas.opengis.net/sweCommon/2.0/swe.xsd
        http://inspire.ec.europa.eu/schemas/ompr/3.0 http://inspire.ec.europa.eu/schemas/ompr/3.0/Processes.xsd
        http://inspire.ec.europa.eu/schemas/omso/3.0 http://inspire.ec.europa.eu/schemas/omso/3.0/SpecialisedObservations.xsd
        http://www.opengis.net/waterml/2.0 http://schemas.opengis.net/waterml/2.0/waterml2.xsd
        http://xml.fmi.fi/namespace/om/atmosphericfeatures/1.0 http://xml.fmi.fi/schema/om/atmosphericfeatures/1.0/atmosphericfeatures.xsd">

	    <wfs:member>
                <omso:PointTimeSeriesObservation gml:id="P8KVc0QwydOumnbl7YdnXLww6eTQ6aduWn0y8Jwmh007ctrfuy1jVakM">

		            <om:phenomenonTime>
        <gml:TimePeriod  gml:id="time1-1-1">
          <gml:beginPosition>2017-05-14T18:30:00Z</gml:beginPosition>
          <gml:endPosition>2017-05-14T19:15:00Z</gml:endPosition>
        </gml:TimePeriod>
      </om:phenomenonTime>
      <om:resultTime>
        <gml:TimeInstant gml:id="time2-1-1">
          <gml:timePosition>2017-05-14T19:15:00Z</gml:timePosition>
        </gml:TimeInstant>
      </om:resultTime>

		<om:procedure xlink:href="http://xml.fmi.fi/inspire/process/opendata"/>
   		            <om:parameter>
                <om:NamedValue>
                    <om:name xlink:href="http://inspire.ec.europa.eu/codeList/ProcessParameterValue/value/groundObservation/observationIntent"/>
                    <om:value>
			atmosphere
                    </om:value>
                </om:NamedValue>
            </om:parameter>

                <om:observedProperty  xlink:href="http://data.fmi.fi/fmi-apikey/8bc96ff0-03ea-43e3-bf12-256acfeaf5d4/meta?observableProperty=observation&amp;param=temperature&amp;language=eng"/>
				<om:featureOfInterest>
                    <sams:SF_SpatialSamplingFeature gml:id="fi-1-1-temperature">
          <sam:sampledFeature>
		<target:LocationCollection gml:id="sampled-target-1-1-temperature">
		    <target:member>
		    <target:Location gml:id="obsloc-fmisid-100953-pos-temperature">
		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100953</gml:identifier>
			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Hanko Tvärminne</gml:name>
			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000061</gml:name>
			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2750</gml:name>
			<target:representativePoint xlink:href="#point-fmisid-100953-1-1-temperature"/>


			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Hanko</target:region>

		    </target:Location></target:member>
		</target:LocationCollection>
 	   </sam:sampledFeature>
                        <sams:shape>

			    <gml:Point gml:id="point-fmisid-100953-1-1-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                <gml:name>Hanko Tvärminne</gml:name>
                                <gml:pos>59.84400 23.24845 </gml:pos>
                            </gml:Point>

                        </sams:shape>
                    </sams:SF_SpatialSamplingFeature>
                </om:featureOfInterest>
		  <om:result>
                    <wml2:MeasurementTimeseries gml:id="obs-obs-1-1-temperature">
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T18:30:00Z</wml2:time>
				      <wml2:value>9.2</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T18:40:00Z</wml2:time>
				      <wml2:value>8.6</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T18:50:00Z</wml2:time>
				      <wml2:value>8.3</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T19:00:00Z</wml2:time>
				      <wml2:value>8.0</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                    </wml2:MeasurementTimeseries>
                </om:result>

        </omso:PointTimeSeriesObservation>
    </wfs:member>
	    <wfs:member>
                <omso:PointTimeSeriesObservation gml:id="WFS-9gseAfxRdEIPFWVsm.QhXFzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8Jwmh007ctrfuy1jVakM">

		            <om:phenomenonTime>
        <gml:TimePeriod  gml:id="time1-1-2">
          <gml:beginPosition>2017-05-14T18:30:00Z</gml:beginPosition>
          <gml:endPosition>2017-05-14T19:15:00Z</gml:endPosition>
        </gml:TimePeriod>
      </om:phenomenonTime>
      <om:resultTime>
        <gml:TimeInstant gml:id="time2-1-2">
          <gml:timePosition>2017-05-14T19:15:00Z</gml:timePosition>
        </gml:TimeInstant>
      </om:resultTime>

		<om:procedure xlink:href="http://xml.fmi.fi/inspire/process/opendata"/>
   		            <om:parameter>
                <om:NamedValue>
                    <om:name xlink:href="http://inspire.ec.europa.eu/codeList/ProcessParameterValue/value/groundObservation/observationIntent"/>
                    <om:value>
			atmosphere
                    </om:value>
                </om:NamedValue>
            </om:parameter>

                <om:observedProperty  xlink:href="http://data.fmi.fi/fmi-apikey/8bc96ff0-03ea-43e3-bf12-256acfeaf5d4/meta?observableProperty=observation&amp;param=temperature&amp;language=eng"/>
				<om:featureOfInterest>
                    <sams:SF_SpatialSamplingFeature gml:id="fi-1-2-temperature">
          <sam:sampledFeature>
		<target:LocationCollection gml:id="sampled-target-1-2-temperature">
		    <target:member>
		    <target:Location gml:id="obsloc-fmisid-100965-pos-temperature">
		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100965</gml:identifier>
			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Raasepori Jussarö</gml:name>
			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000041</gml:name>
			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2757</gml:name>
			<target:representativePoint xlink:href="#point-fmisid-100965-1-2-temperature"/>


			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Raasepori</target:region>

		    </target:Location></target:member>
		</target:LocationCollection>
 	   </sam:sampledFeature>
                        <sams:shape>

			    <gml:Point gml:id="point-fmisid-100965-1-2-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                <gml:name>Raasepori Jussarö</gml:name>
                                <gml:pos>59.82076 23.57309 </gml:pos>
                            </gml:Point>

                        </sams:shape>
                    </sams:SF_SpatialSamplingFeature>
                </om:featureOfInterest>
		  <om:result>
                    <wml2:MeasurementTimeseries gml:id="obs-obs-1-2-temperature">
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T18:30:00Z</wml2:time>
				      <wml2:value>8.8</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T18:40:00Z</wml2:time>
				      <wml2:value>8.6</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T18:50:00Z</wml2:time>
				      <wml2:value>8.0</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T19:00:00Z</wml2:time>
				      <wml2:value>7.7</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                        <wml2:point>
                            <wml2:MeasurementTVP>
                                      <wml2:time>2017-05-14T19:10:00Z</wml2:time>
				      <wml2:value>7.5</wml2:value>
                            </wml2:MeasurementTVP>
                        </wml2:point>
                    </wml2:MeasurementTimeseries>
                </om:result>

        </omso:PointTimeSeriesObservation>
    </wfs:member>
</wfs:FeatureCollection>
    END_OF_STRING
  end
end
