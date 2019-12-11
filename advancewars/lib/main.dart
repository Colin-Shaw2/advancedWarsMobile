import 'dart:io';

import 'package:advancewars/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'notification/notification.dart' as notifications;
import 'package:advancewars/classes/StarterMap.dart';
import 'MapPage.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
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

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var scheduleNotification = notifications.Notification();

  @override
  Widget build(BuildContext context) {
    Bgm().play("music.mp3");
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
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return new Scaffold(
      body: new Swiper.children(
        scrollDirection: Axis.vertical,
        viewportFraction: 0.75,
        scale: 0.9,
        children: <Widget>[
          GestureDetector(
            child: Stack(
            children: <Widget> [
              Container(             
                child: Image.asset(
                "images/bg0.jpeg",width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,),
            ),
            Container(
              child: Center(
                child: new Text(
                  FlutterI18n.translate(context, 'continue'),
                  textScaleFactor: 5.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'VT323'),
                  ),
            ))]
            ), 
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondRoute())),
          ),
          GestureDetector(
            child: Stack(
            children: <Widget> [
              Container(             
                child: Image.asset(
                "images/bg1.jpeg",width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,),
            ),
            Container(
              child: Center(
                child: new Text(
                  FlutterI18n.translate(context, 'new'),
                  textScaleFactor: 5.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'VT323'),
                  ),
            ))]
            ), 
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ThirdRoute())),
          ),
          GestureDetector(
            child: Stack(
            children: <Widget> [
              Container(             
                child: Image.asset(
                "images/bg2.jpeg",width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,),
            ),
            Container(
              child: Center(
                child: new Text(
                  FlutterI18n.translate(context, 'options'),
                  textScaleFactor: 5.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'VT323'),
                  ),
            ))]
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
  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OptionsPage(title: 'Options');
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
        SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(FlutterI18n.translate(context, 'newPage')),
        ),
      ),
    );
  }
}

class Bgm extends WidgetsBindingObserver {
  bool _isRegistered = false;
  AudioPlayer audioPlayer;
  bool isPlaying = false;

  /// Registers a [WidgetsBinding] observer.
  ///
  /// This must be called for auto-pause and resume to work properly.
  void initialize() {
    if (_isRegistered) {
      return;
    }
    _isRegistered = true;
    WidgetsBinding.instance.addObserver(this);
  }

  /// Dispose the [WidgetsBinding] observer.
  void dispose() {
    if (!_isRegistered) {
      return;
    }
    WidgetsBinding.instance.removeObserver(this);
    _isRegistered = false;
  }

  /// Plays and loops a background music file specified by [filename].
  ///
  /// The volume can be specified in the optional named parameter [volume]
  /// where `0` means off and `1` means max.
  ///
  /// It is safe to call this function even when a current BGM track is
  /// playing.
  void play(String filename, {double volume}) async {
    volume ??= 1;

    if (audioPlayer != null && audioPlayer.state != AudioPlayerState.STOPPED) {
      audioPlayer.stop();
    }

    isPlaying = true;
    audioPlayer = await Flame.audio.loopLongAudio(
      filename,
      volume: volume,
    );
  }

  /// Prefetch an audio and store it in the cache.
  ///
  /// Alias of `FlameAudio.load();`.
  Future<File> load(String file) => Flame.audio.load(file);

  /// Prefetch a list of audios and store them in the cache.
  ///
  /// Alias of `FlameAudio.loadAll();`.
  Future<List<File>> loadAll(List<String> files) => Flame.audio.loadAll(files);

  /// Clears the file in the cache.
  ///
  /// Alias of `FlameAudio.clear();`.
  void clear(String file) => Flame.audio.clear(file);

  /// Clears all the audios in the cache.
  /// Alias of `FlameAudio.clearAll();`.
  ///
  void clearAll() => Flame.audio.clearAll();

  /// Handler for AppLifecycleState changes.
  ///
  /// This function handles the automatic pause and resume when the app
  /// lifecycle state changes. There is NO NEED to call this function directly
  /// directly.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying &&
          audioPlayer != null &&
          audioPlayer.state == AudioPlayerState.PAUSED) {
        audioPlayer.resume();
      }
    } else {
      audioPlayer.pause();
    }
  }
}


// Future<void> _options(BuildContext context) async {
//   showDialog<MenuChoice>(
//     context: context,
//     builder: (BuildContext context) {
//       return SimpleDialog(
//         title: Text(FlutterI18n.translate(context, 'optioTitle')),
//           children: <Widget>[
//             SimpleDialogOption(
//               child: Text(
//                 FlutterI18n.translate(context, 'lanOne'),
//               ),
//               onPressed: () {
//                 Locale newLocale = Locale('en');
//                 FlutterI18n.refresh(context, newLocale);
//                 Navigator.pop(context);
//               },
//             ),
//             SimpleDialogOption(
//               child: Text(
//                 FlutterI18n.translate(context, 'lanTwo'),
//               ),
//               onPressed: () {
//                 Locale newLocale = Locale('fr');
//                 FlutterI18n.refresh(context, newLocale);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//       );
//     },
//   );
// }
