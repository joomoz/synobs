require 'rails_helper'

describe "FmiSations" do
  it "When HTTP GET returns one station, it is properly saved to db" do
    canned_answer = answer_with_one_station
    stub_request(:get, /.*/).to_return(body: canned_answer)
    FmiStations.fetch_stations

    expect(ObservationStation.count).to eq(1)
    station = ObservationStation.first
    expect(station.name).to eq("Vantaa Helsinki-Vantaan lentoasema")
    expect(station.id).to eq(100968)
  end

  it "When HTTP GET returns multiple stations, those are properly saved to db" do
    canned_answer = answer_with_multiple_stations
    stub_request(:get, /.*/).to_return(body: canned_answer)
    FmiStations.fetch_stations

    expect(ObservationStation.count).to eq(13)
  end

  it "When HTTP GET returns empty list, nothing is saved to db" do
    canned_answer = empty_answer
    stub_request(:get, /.*/).to_return(body: canned_answer)
    FmiStations.fetch_stations

    expect(ObservationStation.count).to eq(0)
  end

  private
  def empty_answer
    answer = <<-END_OF_STRING
      <wfs:FeatureCollection xmlns:wfs="http://www.opengis.net/wfs/2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:om="http://www.opengis.net/om/2.0" xmlns:ompr="http://inspire.ec.europa.eu/schemas/ompr/3.0" xmlns:omso="http://inspire.ec.europa.eu/schemas/omso/3.0" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:swe="http://www.opengis.net/swe/2.0" xmlns:gmlcov="http://www.opengis.net/gmlcov/1.0" xmlns:sam="http://www.opengis.net/sampling/2.0" xmlns:sams="http://www.opengis.net/samplingSpatial/2.0" xmlns:wml2="http://www.opengis.net/waterml/2.0" xmlns:target="http://xml.fmi.fi/namespace/om/atmosphericfeatures/1.0" timeStamp="2017-05-14T10:21:32Z" numberMatched="0" numberReturned="0" xsi:schemaLocation="http://www.opengis.net/wfs/2.0 http://schemas.opengis.net/wfs/2.0/wfs.xsd http://www.opengis.net/gmlcov/1.0 http://schemas.opengis.net/gmlcov/1.0/gmlcovAll.xsd http://www.opengis.net/sampling/2.0 http://schemas.opengis.net/sampling/2.0/samplingFeature.xsd http://www.opengis.net/samplingSpatial/2.0 http://schemas.opengis.net/samplingSpatial/2.0/spatialSamplingFeature.xsd http://www.opengis.net/swe/2.0 http://schemas.opengis.net/sweCommon/2.0/swe.xsd http://inspire.ec.europa.eu/schemas/ompr/3.0 http://inspire.ec.europa.eu/schemas/ompr/3.0/Processes.xsd http://inspire.ec.europa.eu/schemas/omso/3.0 http://inspire.ec.europa.eu/schemas/omso/3.0/SpecialisedObservations.xsd http://www.opengis.net/waterml/2.0 http://schemas.opengis.net/waterml/2.0/waterml2.xsd http://xml.fmi.fi/namespace/om/atmosphericfeatures/1.0 http://xml.fmi.fi/schema/om/atmosphericfeatures/1.0/atmosphericfeatures.xsd"></wfs:FeatureCollection>
    END_OF_STRING
  end

  def answer_with_one_station
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

  def answer_with_multiple_stations
    answer = <<-END_OF_STRING
      <?xml version="1.0" encoding="UTF-8"?>
      <wfs:FeatureCollection
          timeStamp="2017-05-14T10:17:04Z"
          numberMatched="13"
          numberReturned="13"
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
                      <omso:PointTimeSeriesObservation gml:id="WFS-f3c7_Xng1blm7raoH2oHKKj99vaJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBg5bOHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-1">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-1">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-2jJ5_v4AiHI_vcvreEX1IX2ssMqJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBg5bsXRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-2">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-2">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
      		    <target:Location gml:id="obsloc-fmisid-100971-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100971</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Helsinki Kaisaniemi</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000150</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2978</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-100971-1-2-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Helsinki</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-100971-1-2-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Helsinki Kaisaniemi</gml:name>
                                      <gml:pos>60.17523 24.94459 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-2-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-Rdtth1I6hC4RacTX.f1itevNZz.JTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBg5btHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-3">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-3">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-3-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-3-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-100974-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100974</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Lohja Porla</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000023</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2706</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-100974-1-3-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Lohja</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-100974-1-3-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Lohja Porla</gml:name>
                                      <gml:pos>60.24446 24.04951 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-3-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-SK82U0BH2Jwdm6LlmI6uhlP_R8KJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBg5btnRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-4">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-4">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-4-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-4-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-100976-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100976</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Vihti Maasoja</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000165</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2758</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-100976-1-4-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Vihti</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-100976-1-4-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Vihti Maasoja</gml:name>
                                      <gml:pos>60.41875 24.39862 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-4-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-eJ9yX5Em_oQGQk0535gZ0.ImijmJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBg5ctnRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-5">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-5">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-5-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-5-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-100996-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">100996</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Helsinki Harmaja</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000153</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2795</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-100996-1-5-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Helsinki</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-100996-1-5-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Helsinki Harmaja</gml:name>
                                      <gml:pos>60.10512 24.97539 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-5-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>8.6</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-r4fNWY.Jrbqg5IwAf.XH88S6s9OJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBiwYNHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-6">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-6">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-6-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-6-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-101004-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">101004</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Helsinki Kumpula</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000138</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2998</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-101004-1-6-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Helsinki</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-101004-1-6-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Helsinki Kumpula</gml:name>
                                      <gml:pos>60.20307 24.96131 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-6-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-G48vxj9AzZ3H2_wW9z0NRX0DnV.JTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBixZsHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-7">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-7">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-7-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-7-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-101130-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">101130</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Hyvinkää Hyvinkäänkylä</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000152</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2829</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-101130-1-7-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Hyvinkää</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-101130-1-7-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Hyvinkää Hyvinkäänkylä</gml:name>
                                      <gml:pos>60.59589 24.80300 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-7-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>13.9</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-l8BxFlEzBFJ6vJfpkGXWeivZyaOJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBixaOXRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-8">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-8">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-8-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-8-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-101149-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">101149</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Nurmijärvi Röykkä</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000151</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2983</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-101149-1-8-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Nurmijärvi</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-101149-1-8-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Nurmijärvi Röykkä</gml:name>
                                      <gml:pos>60.50878 24.65373 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-8-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-8dcAo1pjUZKMEqdIOoVKhqbHbBGJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLBixasHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-9">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-9">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-9-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-9-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-101150-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">101150</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Hämeenlinna Katinen</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-16000125</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2754</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-101150-1-9-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Hämeenlinna</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-101150-1-9-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Hämeenlinna Katinen</gml:name>
                                      <gml:pos>60.99920 24.49163 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-9-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-JcOYMLAIKkJgIbums7zaHiatuamJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLNkzYsHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-10">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-10">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-10-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-10-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-132310-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">132310</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Helsinki Kaivopuisto</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-10022814</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2960</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-132310-1-10-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Helsinki</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-132310-1-10-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Helsinki Kaivopuisto</gml:name>
                                      <gml:pos>60.15363 24.95622 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-10-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-9rD1oz7XHmeBr7oC4mmE9XeaA5iJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zGLNuxcOXRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-11">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-11">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-11-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-11-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-137189-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">137189</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Vantaa Helsinki-Vantaa lentoasema AWOS</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-137189</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">NaN</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-137189-1-11-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Vantaa</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-137189-1-11-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Vantaa Helsinki-Vantaa lentoasema AWOS</gml:name>
                                      <gml:pos>60.31583 24.90697 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-11-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>NaN</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-N2mltby_fYLZAzdpWxOlwE1RjP2JTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zHDVk2buHRry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-12">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-12">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-12-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-12-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-852678-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">852678</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Espoo Nuuksio</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-852678</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2986</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-852678-1-12-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Espoo</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-852678-1-12-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Espoo Nuuksio</gml:name>
                                      <gml:pos>60.29128 24.56788 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-12-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>14.7</wml2:value>
                                  </wml2:MeasurementTVP>
                              </wml2:point>
                          </wml2:MeasurementTimeseries>
                      </om:result>

              </omso:PointTimeSeriesObservation>
          </wfs:member>
      	    <wfs:member>
                      <omso:PointTimeSeriesObservation gml:id="WFS-OKFViQOp7fUx4_LohR4xh_7.OyaJTowqYWbbpdOt.Lnl5dsPTTv3c3Trvlw9NGXk6ddNO3L2w7OuXhh08oWliy59O6pp25bUP8KVc8bxwmNj5c61ItCnHdOmjJq4Z2XdkqaduW1D_ClXPkkkJnZtunnpyc6zHDdo4bM3Rry.e._lkv7.2Xl35aemHFsyxMzZh6ZefSJmbN.PDsy1qZtN.NJXdemZw1tuHxE08.mHdjy0rV0IDS24fEXhvx6Oc4Mcze25emXfQw8sO3L0y8uda3TLt4ZeWHp15ZWtt08.endnqZfHSsadhnNrd12z81Pph6ad.7nOE1uPXDs09PMndm3xNbn0w9NO_dU88MtaG_hl3ZMPTC3OfTfyy5OPXLy839OStMLNt0unW_Fzy8u2Hpp37ubp13y4emjLydOumnbl7YdnXLww6eTQ6aduWn0y8J1Gh007ctrfuy1jVakM">

      		            <om:phenomenonTime>
              <gml:TimePeriod  gml:id="time1-1-13">
                <gml:beginPosition>2017-05-14T10:10:00Z</gml:beginPosition>
                <gml:endPosition>2017-05-14T10:17:00Z</gml:endPosition>
              </gml:TimePeriod>
            </om:phenomenonTime>
            <om:resultTime>
              <gml:TimeInstant gml:id="time2-1-13">
                <gml:timePosition>2017-05-14T10:17:00Z</gml:timePosition>
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
                          <sams:SF_SpatialSamplingFeature gml:id="fi-1-13-temperature">
                <sam:sampledFeature>
      		<target:LocationCollection gml:id="sampled-target-1-13-temperature">
      		    <target:member>
      		    <target:Location gml:id="obsloc-fmisid-874863-pos-temperature">
      		        <gml:identifier codeSpace="http://xml.fmi.fi/namespace/stationcode/fmisid">874863</gml:identifier>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/name">Espoo Tapiola</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/geoid">-874863</gml:name>
      			<gml:name codeSpace="http://xml.fmi.fi/namespace/locationcode/wmo">2985</gml:name>
      			<target:representativePoint xlink:href="#point-fmisid-874863-1-13-temperature"/>


      			<target:region codeSpace="http://xml.fmi.fi/namespace/location/region">Espoo</target:region>

      		    </target:Location></target:member>
      		</target:LocationCollection>
       	   </sam:sampledFeature>
                              <sams:shape>

      			    <gml:Point gml:id="point-fmisid-874863-1-13-temperature" srsName="http://www.opengis.net/def/crs/EPSG/0/4258" srsDimension="2">
                                      <gml:name>Espoo Tapiola</gml:name>
                                      <gml:pos>60.17802 24.78732 </gml:pos>
                                  </gml:Point>

                              </sams:shape>
                          </sams:SF_SpatialSamplingFeature>
                      </om:featureOfInterest>
      		  <om:result>
                          <wml2:MeasurementTimeseries gml:id="obs-obs-1-13-temperature">
                              <wml2:point>
                                  <wml2:MeasurementTVP>
                                            <wml2:time>2017-05-14T10:10:00Z</wml2:time>
      				      <wml2:value>10.3</wml2:value>
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
