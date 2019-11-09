import 'package:flutter/material.dart';

class Ad {
  String imageLink;
  String companyName;
  int id;

  Ad({this.id, this.imageLink, this.companyName});

  factory Ad.fromMap(Map map) {
    return Ad(
      id: map['id'],
      imageLink: map['imageLink'],
      companyName: map['companyName'],
    );
  }
}