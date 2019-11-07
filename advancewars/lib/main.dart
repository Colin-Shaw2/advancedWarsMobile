
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'src/config.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Advance Wars',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomeScreen()
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: 
        GestureDetector(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          // autoplay: false,
          itemCount: images.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),
        onTap: () => _popupDialog(context),
      ),   
    );
  }
}

 void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('UNAVAILABLE'),
            content: Text('Avaliable in a future update'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK')),
            ],
          );
        });
  }