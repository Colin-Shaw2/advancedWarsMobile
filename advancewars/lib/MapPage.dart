import 'package:advancewars/classes/GameDriver.dart';
import 'package:advancewars/classes/StarterMap.dart';
import 'package:advancewars/classes/WarMap.dart';
import 'package:advancewars/classes/woodsMap.dart';
import 'package:advancewars/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'classes/mountainMap.dart';
import 'databases/saving.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'classes/terrain/Mountain.dart';

WarMap currentMap = StarterMap();

class MapPage extends StatefulWidget {
  MapPage(String s, {Key key, this.selectedMap}) : super(key: key);
  String selectedMap;
  @override
  _MapPageState createState() => _MapPageState();
}

GameDriver driver = GameDriver.twoPlayers(currentMap);
bool savedMapExists = false;
bool loaded = false;
bool navigated = false;
class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {

    if(driver.activeMap.gameOver && !navigated) {
      _backToHome(context);
    }
    if(widget.selectedMap == 'starterMap') {
      driver.activeMap = StarterMap();
    } else if (widget.selectedMap == 'mountainMap') {
      driver.activeMap = MountainMap();
    } else if (widget.selectedMap == 'woodsMap'){
      driver.activeMap = WoodsMap();
    }

//     if (Saving().getLocalSavedMap() == null) {
//       getSavedMap();
//     }
//     ;
    savedMap();
    if (savedMapExists && !loaded) {
      getSavedMap();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (driver.activeMap.inWaitingState() || driver.activeMap.turnEnded) {
          } else {
            _menu(context);
          }
        });
      },
      onTapDown: (TapDownDetails details) {
        //if the animation is still playing you are locked out
        if (driver.activeMap.turnEnded) {
        }
        // do nothing if waiting for other gesture detector
        else if (!driver.activeMap.inUnconfirmedMoveState ||
            (driver.activeMap.inUnconfirmedMoveState &&
                driver.activeMap.waitingToAttack)) {
          double x = details.localPosition.dx;
          double y = details.localPosition.dy;

          double xBucket =
              MediaQuery.of(context).size.width / driver.activeMap.xDim;
          double yBucket =
              MediaQuery.of(context).size.height / driver.activeMap.yDim;

          driver.handleDownPress(
            x ~/ xBucket,
            y ~/ yBucket,
          );
        }
        setState(() {});
      },
      child: Scaffold(
        body: Builder(
          builder: (BuildContext scaffContext) {
            return driver.activeMap.display(driver.activePlayer, scaffContext);
          },
        ),
      ),
    );
  }

  Future<void> getSavedMap() async {
    GameDriver loadedDriver = await Saving().getLocalSavedMap();
    setState(() {
      driver = loadedDriver;
      loaded = true;
    });
  }

  Future<void> savedMap() async {
    GameDriver loadDriver = await Saving().getLocalSavedMap();
    if (loadDriver != null) {
      setState(() {
        savedMapExists = true;
      });
    }
  }

  Future<void> _backToHome(context) async {
    driver.activeMap.gameOver = false;
    driver.activeMap.blueVictory = false;
    driver.activeMap.orangeVictory = false;
    await Future.delayed(Duration.zero, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      });
    setState(() {
      navigated = true;
      loaded = false;
    });
    }
}


Future<void> _menu(BuildContext context) async {
  var choice = await showDialog<MenuChoice>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(FlutterI18n.translate(context, 'menu')),
        children: <Widget>[
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context, 'giveUp')),
            onPressed: () {
              if(driver.activePlayer == 0) {
                driver.activeMap.blueVictory = true;
              }
              else {
                driver.activeMap.orangeVictory = true;
              }
              Navigator.pop(context, MenuChoice.giveUp);
            },
          ),
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context, 'save')),
            onPressed: () {
              Saving().saveMap(driver.activeMap, driver.activePlayer);
              Navigator.pop(context, MenuChoice.save);
            },
          ),
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context, 'end')),
            onPressed: () {
              driver.endTurn();
              Navigator.pop(context, MenuChoice.end);
            },
          ),
        ],
      );
    },
  );
}

enum MenuChoice { giveUp, save, end }
