import 'dart:html';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MyEvenItem extends StatefulWidget {
  final int fromOtherSide;

    final List<Map<String, dynamic>> myListMON = [
    {
      "idMON" : 0,
      "Name" : "Morning",
      "Icon": Icons.wb_sunny_rounded
    },
    {
      "idMON" : 1,
      "Name" : "Night",
      "Icon": Icons.mode_night_rounded
    },
  ];
  

  MyEvenItem({
    Key? key,
    this.fromOtherSide = 0
  }): super(key: key);
  


  @override
  State<MyEvenItem> createState() => _MyEvenItemState();
}

class _MyEvenItemState extends State<MyEvenItem> {

  Widget build(BuildContext context) {
    return 
    GFListTile(
        titleText:'Succes',
        subTitleText:'Selamat',
        icon: Icon(Icons.done)
    );
  }
}