import 'package:advancewars/databases/saving.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:latlong/latlong.dart';

class FrequencyChart extends StatefulWidget {
  FrequencyChart({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FrequencyChartState createState() => _FrequencyChartState();
}

class LocationFrequency {
  LatLng location;
  int frequency;
  LocationFrequency({this.location, this.frequency});
}

class _FrequencyChartState extends State<FrequencyChart> {
  List<LatLng> locations = [];
  bool loaded = false;
  @override
  Widget build(BuildContext context) {
    if(!loaded) {
      loadingLocations();
    }
    if(locations.length > 0)
    {
      return Scaffold(
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, 'locationChart')),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
            height: 300.0,
            width: 500,
            child: charts.BarChart(
              [
                charts.Series<LocationFrequency, String>(
                  id: 'Location Frequency',
                  colorFn: (a,b) => charts.MaterialPalette.blue.shadeDefault,
                  domainFn: (LocationFrequency freq, unused) => freq.location.toString(),
                  measureFn: (LocationFrequency freq, unused) => freq.frequency,
                  data: _calculateLocationFrequencies(),
                ),
              ],
              animate: true,
              vertical: false,
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
    else {
      return Scaffold(body: Text("No Data Present!"),);
    }
  }



  Future<void> loadingLocations() async {
    List<LatLng> loadedLocations = await Saving().loadLocations();
    setState(() {
      loaded = true;
      locations = loadedLocations;
    });
  }

  List<LocationFrequency> _calculateLocationFrequencies() {
    var frequencies = {};
    for (LatLng location in locations) {
      if(frequencies.containsKey(location)) {
        frequencies[location]++;
      }
      else {
        frequencies[location] = 1;
      }
    }

    return locations.map((l) => LocationFrequency(
      location: l,
      frequency: frequencies[l]
    )).toList();
  }
}