import 'dart:io';

import 'package:advancewars/classes/WarMap.dart';
import 'package:flutter/material.dart';

class DayAnimation extends StatefulWidget {
  final int day;
  WarMap warmap;

  DayAnimation({Key key, this.day, this.warmap}) : super(key: key);

  @override 
  _DayAnimationState createState() => _DayAnimationState();
}

class _DayAnimationState extends State<DayAnimation> {
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
        color: Colors.blue.withOpacity(0.6),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getDayImages(),))));
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

    List<Widget> _getDayImages() {
      List<Widget> images = [];
      images.add(Container(padding: EdgeInsets.only(right: 10), 
        child: Image.asset("resources/days/Day.png")));
      int day = widget.day;
      if(day > 10) {
        images.add(Container(padding: EdgeInsets.only(right:2), 
        child: Image.asset("resources/days/${day~/10}.png")));
      }
      images.add(Image.asset("resources/days/${day%10}.png"));
      return images;
    }
}