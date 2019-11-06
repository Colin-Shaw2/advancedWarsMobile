import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
    body: Swiper(
        itemBuilder: (BuildContext context,int index){
          switch(index) {
            case(0): {
              return Text("Continue");
              break;
            }
            case(1): {
              return Text("New");
              break;
            }
            case(2):
            {
              return Text("Stats");
              break;
            }
          }
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}
