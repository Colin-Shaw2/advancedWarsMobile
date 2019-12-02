import 'package:advancewars/classes/StarterMap.dart';
import 'package:advancewars/classes/WarMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'databases/saving.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

WarMap currentMap = new StarterMap(16, 9);
bool savedMapExists = false;
bool loaded = false;

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
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
            _menu(context);
          });
        },
        onTapDown: (TapDownDetails details){
          double x =details.localPosition.dx;
          double y =details.localPosition.dy;

          double xBucket = MediaQuery.of(context).size.width / currentMap.xDim;
          double yBucket = MediaQuery.of(context).size.height / currentMap.yDim;

          // int g = tx ~/ xBucke;
          // int h = y ~/ yBucket;
          //print("changed $xBucket + $yBucket");
          
          currentMap.tileSelect(x ~/ xBucket, y ~/ yBucket,);
          setState(() {});
        },
        child: currentMap.display());
  }

  Future<void> getSavedMap() async {
    WarMap map = await Saving().getLocalSavedMap();
    setState(() {
      currentMap = map;
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
        title: Text(FlutterI18n.translate(context, 'menu')),
        children: <Widget>[
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context, 'giveUp')),
            onPressed: () {
              Navigator.pop(context, MenuChoice.giveUp);
            },
          ),
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context, 'save')),
            onPressed: () {
              Saving().saveMap(currentMap);
              Navigator.pop(context, MenuChoice.save);
            },
          ),
          SimpleDialogOption(
            child: Text(FlutterI18n.translate(context, 'end')),
            onPressed: () {
              Navigator.pop(context, MenuChoice.end);
            },
          ),
        ],
      );
    },
  );
}


enum MenuChoice{
  giveUp,
  save,
  end
}