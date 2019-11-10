
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'src/config.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter/services.dart';

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
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return new Scaffold(
        body: 
        GestureDetector(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
            // home: ThirdRoute();
          },
          itemCount: images.length,
          scrollDirection: Axis.vertical,
          pagination: new SwiperPagination(alignment: Alignment.centerLeft),
          control: new SwiperControl(),
        ),
        onTap: () =>
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            ),
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

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

// class ThirdRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//       return new Image.asset(
//         images[0],
//         fit: BoxFit.fill,
//       );   
//   }
// }