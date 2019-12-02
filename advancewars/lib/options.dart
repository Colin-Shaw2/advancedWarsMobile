// CSCI 4100U - 10a Maps

import 'package:advancewars/ads/ad_carousel.dart';
import 'package:advancewars/databases/saving.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class OptionsPage extends StatefulWidget {
  OptionsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  var _geolocator = Geolocator();
  var centre;
  TextEditingController controller = TextEditingController();
  void _updateLocation(userLocation) {
    if (controller.text == '')
    {
      _geolocator.placemarkFromCoordinates(userLocation.latitude, userLocation.longitude).then((List<Placemark> places) {
        print('Reverse geocoding results:');
        for (Placemark place in places) {
          setState((){
            controller.text = '\t${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea}';
          });
        }
      });
    }
    setState(() {
      centre = LatLng(userLocation.latitude, userLocation.longitude);
    });
  }
  @override
  void initState() {
    _geolocator.checkGeolocationPermissionStatus().then((GeolocationStatus geolocationStatus) {
      print('Geolocation status: $geolocationStatus.');
    });

    _geolocator.getPositionStream(LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 10000))
      .listen((userLocation) {
        _updateLocation(userLocation);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    print(centre);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    if(centre != null)
    {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row( 
      children: <Widget>[
        Container(padding: EdgeInsets.all(10), width: 300, height: 300, child: FlutterMap(
        options: MapOptions(
          minZoom: 14.0,
          center: centre,
        ),
        layers: [
          TileLayerOptions(
            /*
            // for OpenStreetMaps:
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            */
            ///*
            // for MapBox:
            urlTemplate: 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoibW1lcHN0ZWFkIiwiYSI6ImNrM2hzdTF5ZTAxMGIzaGw2Z2tuMzRld3UifQ.gm6wZqU27OTzCDSMD_DLwA',
              'id': 'mapbox.streets'
            }
          ),
                    MarkerLayerOptions(
            markers: [
              Marker(
                width: 45.0,
                height: 45.0,
                point: centre,
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      print('Icon clicked');
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
       Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
            Container(padding: EdgeInsets.only(left: 10, top: 20, right:10), height: 100, width: 300, 
              child: TextField(
                controller: controller
              )), 
          Container(padding: EdgeInsets.only(left: 10, top: 20, right:10), height: 100, width: 200, 
          child:
          FlatButton(
            color: Colors.blue,
            child: Text("Save Location"),
            onPressed: (() {
              Saving().saveLocation(controller.text, centre);
            }),
      
      )),
      AdCarousel(title: 'ads'),
      
       ])      
      ],)
    );
  }
  else {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Text("Loading...."));
  }
  }
}
