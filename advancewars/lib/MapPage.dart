import 'package:advancewars/classes/GameDriver.dart';
import 'package:advancewars/classes/StarterMap.dart';
import 'package:advancewars/classes/WarMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'databases/saving.dart';

StarterMap currentMap = new StarterMap(16, 9);

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MapPageState createState() => _MapPageState();
}

GameDriver driver = GameDriver.twoPlayers(currentMap);
bool savedMapExists = false;
bool loaded = false;

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
//     if (Saving().getLocalSavedMap() == null) {
//       getSavedMap();
//     }
//     ;
    savedMap();
    if(savedMapExists && !loaded) {
      getSavedMap();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return GestureDetector(
      onLongPress: () {
        print("longPress");
        setState(() {
          if (driver.activeMap.waitingToAttack) {
            driver.activeMap.waitingToAttack = false;
          } else {
            _menu(context);
          }
        });
      },
      onTapDown: (TapDownDetails details) {
        // do nothing if waiting for other gesture dector
        if (!driver.activeMap.inUnconfirmedMoveState ||
        (driver.activeMap.inUnconfirmedMoveState && driver.activeMap.waitingToAttack)) {
          double x = details.localPosition.dx;
          double y = details.localPosition.dy;

          double xBucket =
              MediaQuery.of(context).size.width / driver.activeMap.xDim;
          double yBucket =
              MediaQuery.of(context).size.height / driver.activeMap.yDim;

          // int g = tx ~/ xBucke;
          // int h = y ~/ yBucket;
          //print("changed $xBucket + $yBucket");

          driver.handleDownPress(
            x ~/ xBucket,
            y ~/ yBucket,
          );
        }
        setState(() {});
      },
      child: driver.activeMap.display(),
    );
  }

  Future<void> getSavedMap() async {
    WarMap map = await Saving().getLocalSavedMap();
    setState(() {
      driver.activeMap = map;
      loaded = true; 
    });
  }
  Future<void> savedMap() async {
    WarMap map = await Saving().getLocalSavedMap();
    if (map != null) {
      setState(() {
        savedMapExists = true;
      });
    }
  }
}

Future<void> _menu(BuildContext context) async {
  var choice = await showDialog<MenuChoice>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Menu'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('Give Up'),
            onPressed: () {
              Navigator.pop(context, MenuChoice.giveUp);
            },
          ),
          SimpleDialogOption(
            child: Text('Save'),
            onPressed: () {
              Saving().saveMap(driver.activeMap);
              Navigator.pop(context, MenuChoice.save);
            },
          ),
          SimpleDialogOption(
            child: Text('End'),
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
