import 'package:flutter/material.dart';
import 'ad.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdCarousel extends StatefulWidget {
  final String title;

  AdCarousel({Key key, this.title}) : super(key: key);

  @override 
  _AdCarouselState createState() => _AdCarouselState();
}

class _AdCarouselState extends State<AdCarousel> {
  List<Ad> _ads;

  @override 
  void initState() {
    super.initState();

    _loadAds();
  }

    Future<void> _loadAds() async {
    var response = await http.get('https://my-json-server.typicode.com/Colin-Shaw2/advancedWarsMobile/ads');
    if (response.statusCode == 200) {
      setState(() {
        _ads = [];

        List data = jsonDecode(response.body);
        for (var item in data) {
          _ads.add(Ad.fromMap(item));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Align(alignment: Alignment.bottomCenter, child:
      CarouselSlider(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        height: 50.0,
        items: _ads == null ?
        [Container(
          width: 500,
          height: 50,
          child: Image.network("https://www.underconsideration.com/brandnew/archives/google_broken_image_00_b_logo_detail.gif")
        )] : _ads.map((ad) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 500,
                height: 50,
                child: Image.network(ad.imageLink));
          });
        }).toList()
    )));
  }
}