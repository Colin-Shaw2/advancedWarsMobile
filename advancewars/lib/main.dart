
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';

//for background music
import 'package:flame/flame_audio.dart';
import 'package:flame/bgm.dart';
import 'package:flame/flame.dart';


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
    //Code for music not working currently
      // Flame.bgm.initialize();
      // Bgm audio = Bgm();
      // audio.play('music/music.mp3');
      // Flame.audio.clear('music/music.mp3');

    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new Scaffold(
        body: 
        new Swiper.children(
          scrollDirection: Axis.vertical,
          pagination: new SwiperPagination(alignment: Alignment.centerLeft),
          control: new SwiperControl(),
            children: <Widget>[
              GestureDetector(
              child: new Image.asset(
                "images/bg0.jpeg",
                fit: BoxFit.fill,
              ),
              onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                ),
              ),
              GestureDetector(
                child: new Image.asset(
                  "images/bg1.jpeg",
                  fit: BoxFit.fill,
                ),
              onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdRoute()),
                ),
              ),
              GestureDetector(
                child: new Image.asset(
                  "images/bg2.jpeg", 
                  fit: BoxFit.fill,
                  ),
                  onTap: () => _popupDialog(context),
                ),
            ],),
          // },   
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
          child: Text('Continue Page Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('New Page Go back!'),
        ),
      ),
    );
  }
}