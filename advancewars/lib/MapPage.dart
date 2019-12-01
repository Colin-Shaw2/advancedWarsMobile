import 'package:advancewars/classes/StarterMap.dart';
import 'package:advancewars/classes/WarMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'databases/saving.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

StarterMap currentMap = new StarterMap(16, 9);

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    if(Saving().getLocalSavedMap() == null) {
      getSavedMap();
    };
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
        child: currentMap.display());
  }

  Future<void> getSavedMap() async {
    WarMap map = await Saving().getLocalSavedMap();
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


enum MenuChoice{
  giveUp,
  save,
  end
}