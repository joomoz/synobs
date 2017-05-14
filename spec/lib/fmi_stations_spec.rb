require 'rails_helper'

describe "FmiSations" do
  it "When HTTP GET returns one entry, it is properly saved to db" do
    canned_answer = answer
    stub_request(:get, /.*/).to_return(body: canned_answer)

    FmiStations.fetch_stations

    expect(ObservationStation.count).to eq(1)
    station = ObservationStation.first
    expect(station.name).to eq("Vantaa Helsinki-Vantaan lentoasema")
    expect(station.id).to eq(100968)
  end

  def answer
    answer = <<-END_OF_STRING

      <?xml version="1.0" encoding="UTF-8"?>
      <wfs:FeatureCollection
          timeStamp="2017-05-14T09:31:00Z"
          numberMatched="1"
          numberReturned="1"
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
                      <omso:PointTimeSeriesObservation gml:id="WFS-MwBQgaxAucJGvlOqKTF5b0qUrd2JTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc4afmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXOl0MJnZtunnpyc6zGLBg5bOHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakMA">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-1">
                <gml:beginPosition>2017-05-14T09:00:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T09:31:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-1">
                <gml:timePosition>2017-05-14T09:31:00Z</gml:timePosition>
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
      		    <target:Location gml:id="obsloc-fmisid-100968-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100968</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Vantaa Helsinki-Vantaan lentoasema</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000063</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2974</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-100968-1-1-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Vantaa</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-100968-1-1-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Vantaa Helsinki-Vantaan lentoasema</gml:name>
                                      <gml:pos>60.32670 24.95675 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-1-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T09:00:00Z</wml2:time>
      				      <wml2:value>12.7</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T09:10:00Z</wml2:time>
      				      <wml2:value>13.2</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T09:20:00Z</wml2:time>
      				      <wml2:value>13.4</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T09:30:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
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
