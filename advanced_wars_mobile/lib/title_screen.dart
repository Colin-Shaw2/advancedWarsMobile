import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleScreen extends StatelessWidget {
String titleImage = "https://cdn02.nintendo-europe.com/media/images/10_share_images/games_15/game_boy_advance_7/SI_GBA_AdvanceWars_image1600w.jpg";
@override
Widget build(BuildContext context) {
  return Scaffold(body: 
    Container(width: 400, height: 800, child:
      FlatButton(
        child: (Image.network(titleImage)),
        onPressed: () {Navigator.pushNamed(context, '/main_menu');},
      )
    )
  );
}



}