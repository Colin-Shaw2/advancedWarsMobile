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
    scheduleNotification.init();
    scheduleNotification.sendNotificationWeekly();
    scheduleNotification.sendAbsentNotification('payload');

    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new Scaffold(
      body: new Swiper.children(
        // scrollDirection: Axis.vertical,
        // pagination: new SwiperPagination(alignment: Alignment.centerLeft),
        // control: new SwiperControl(),
        scrollDirection: Axis.horizontal,
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
                    builder: (context) => MapPage(
                          title: "Map Page",
                        ))),
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
            onTap: () => _popupDialog(context),
          ),
        ],
      ),
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
  var scheduleNotification = notifications.Notification();
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
