
import 'package:advancewars/notification/notification.dart' as prefix0;
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'notification/notification.dart' as notifications;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scheduleNotification = notifications.Notification();
  @override
  Widget build(BuildContext context) {
    scheduleNotification.init();
    scheduleNotification.sendNotificationWeekly();
    scheduleNotification.sendAbsentNotification('payload');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
    body: new Swiper(
  itemBuilder: (BuildContext context, int index) {
    return new Image.network(
      "http://via.placeholder.com/288x188",
      fit: BoxFit.fill,
    );
  },
  itemCount: 10,
  viewportFraction: 0.8,
  scale: 0.9,
)
,
    );
  }
}