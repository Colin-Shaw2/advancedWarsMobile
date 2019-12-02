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


class _MapPageState extends State<MapPage> {
  
  GameDriver driver = GameDriver.twoPlayers(currentMap);
  
  @override
  Widget build(BuildContext context) {
    if (Saving().getLocalSavedMap() == null) {
      getSavedMap();
    }
    ;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return GestureDetector(
      onLongPress: () {
        print("longPress");
        setState(() {
          _menu(context);
        });
      },
      onTapDown: (TapDownDetails details) {
        // do nothing if waiting for other gesture dector
        if (!currentMap.inUnconfirmedMoveState) {
          double x = details.localPosition.dx;
          double y = details.localPosition.dy;

          double xBucket = MediaQuery.of(context).size.width / currentMap.xDim;
          double yBucket = MediaQuery.of(context).size.height / currentMap.yDim;

          // int g = tx ~/ xBucke;
          // int h = y ~/ yBucket;
          //print("changed $xBucket + $yBucket");

          currentMap.tileSelect(
            x ~/ xBucket,
            y ~/ yBucket,
          );
          setState(() {});
        }
      },
      child: currentMap.display(),
    );
  }

  Future<void> getSavedMap() async {
    WarMap map = await Saving().getLocalSavedMap();
    print("Hello");
    setState(() {
      currentMap = map;
    });
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
              Saving().saveMap(currentMap);
              Navigator.pop(context, MenuChoice.save);
            },
          ),
          SimpleDialogOption(
            child: Text('End'),
            onPressed: () {
              Navigator.pop(context, MenuChoice.end);
            },
          ),
        ],
      );
    },
  );
}

enum MenuChoice { giveUp, save, end }
