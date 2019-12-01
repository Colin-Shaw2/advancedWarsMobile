import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'notification/notification.dart' as notifications;
import 'package:advancewars/classes/StarterMap.dart';
import 'MapPage.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'title',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomeScreen(),
        localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: false,
          fallbackFile: 'fr',
          path: 'assets',
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
        );
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
            onTap: () => _options(context),
          ),
        ],
      ),
      // },
    );
  }
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

Future<void> _options(BuildContext context) async {
  var choice = await showDialog<MenuChoice>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(FlutterI18n.translate(context, 'optionTitle')),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                FlutterI18n.translate(context, 'lanOne'),
              ),
              onPressed: () {
                //This setstate is giving me an error and im not sure why
                // Locale newLocale = Locale('en');
                // setState(() {
                //   FlutterI18n.refresh(context, newLocale);
                // });
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text(
                FlutterI18n.translate(context, 'lanTwo'),
              ),
              onPressed: () {
                //This setstate is giving me an error and im not sure why
                // Locale newLocale = Locale('fr');
                // setState(() {
                //   FlutterI18n.refresh(context, newLocale);
                // });
                Navigator.pop(context);
              },
            ),
          ],
      );
    },
  );
}
