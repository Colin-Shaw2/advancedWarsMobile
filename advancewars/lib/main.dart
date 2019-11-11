import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'notification/notification.dart' as notifications;
import 'package:advancewars/classes/StarterMap.dart';
import 'MapPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Advance Wars',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  var scheduleNotification = notifications.Notification();

  @override
  Widget build(BuildContext context) {
    //Code for music not working currently
      // Flame.bgm.initialize();
      // Bgm audio = Bgm();
      // audio.play('music/music.mp3');
      // Flame.audio.clear('music/music.mp3');
    var scheduleNotification = notifications.Notification();
    scheduleNotification.init();
    scheduleNotification.sendNotificationWeekly();
    scheduleNotification.sendAbsentNotification('payload');

    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return new Scaffold(
      body: new Swiper.children(
        // scrollDirection: Axis.vertical,
        // pagination: new SwiperPagination(alignment: Alignment.centerLeft),
        // control: new SwiperControl(),
        scrollDirection: Axis.vertical,
        viewportFraction: 0.75,
        scale: 0.9,
        children: <Widget>[
          GestureDetector(
            child: new Image.asset(
              "images/bg0.jpeg",
              fit: BoxFit.fill,
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondRoute())),
          ),
          GestureDetector(
            child: new Image.asset(
              "images/bg1.jpeg",
              fit: BoxFit.fill,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdRoute()),
            ),
          ),
          GestureDetector(
            child: new Image.asset(
              "images/bg2.jpeg",
              fit: BoxFit.fill,
            ),
            onTap: () => showInfoFlushbar(context)
          ),
        ],
      ),
      // },
    );
  }
}

  void showInfoFlushbar(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Flushbar(
      title: 'UNAVALIABLE',
      message: 'Avaliable at a future update',
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 4),
    )..show(context);
  }

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapPage();
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
