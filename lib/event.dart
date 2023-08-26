import 'dart:html';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MyEvenItem extends StatefulWidget {
  final int fromOtherSide;
  

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