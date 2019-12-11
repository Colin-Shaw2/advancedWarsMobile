import 'dart:io';

import 'package:advancewars/classes/WarMap.dart';
import 'package:flutter/material.dart';

class VictoryAnimation extends StatefulWidget {
  WarMap warmap;
  String colour;

  VictoryAnimation({Key key, this.warmap, this.colour}) : super(key: key);

  @override 
  _VictoryAnimationState createState() => _VictoryAnimationState();
}

class _VictoryAnimationState extends State<VictoryAnimation> {
    bool visible = false;
    bool displayed = false;
    Widget build(BuildContext context) {
      if(!displayed) {
        _toggleBox();
      }
      return Align(alignment: Alignment.center, child:
      AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Duration(seconds: 1),
        child: Container(
        color: _getColour(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Image.asset('resources/victory/Victory.png')]))));
    }

    Color _getColour() {
      if(widget.colour == "Orange") {
        return Colors.orange.withOpacity(0.7);
      }
      else {
        return Colors.blue.withOpacity(0.7);
      }
    }

    Future<void> _toggleBox() async {
      await new Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        visible = true;
      });
      await new Future.delayed(const Duration(milliseconds: 3500));
      setState(() {
        visible = false;
        displayed = true;
      });
    }
}