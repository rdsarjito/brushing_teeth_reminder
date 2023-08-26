import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'notification.dart';
import 'scanner.dart';

class MyHomePage extends StatefulWidget {
  final int fromOtherSide;
  final List<Map<String, dynamic>> test;
  

  const MyHomePage({
    Key? key,
    this.fromOtherSide = 0,
    required this.test
  }): super(key: key);
  


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget.fromOtherSide
    // inspect("object");
    // inspect(widget.test);
    print(inspect(widget.test));
    return Scaffold(
      appBar: AppBar(title: const Text('Brushing Teeth Reminder')),
      body: Stack(
        children: [
          calendarWidget(),
          Positioned(
            bottom: 25,
            right: 20,
            child: floatingButtonMore(),
          ),
        ],
      ),
    );
  }

  Widget calendarWidget(){
    return Column(
      children: [
        TableCalendar(
          locale: "en_US",
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          // selectedDayPredicate: Ele,
          focusedDay: DateTime.now(),
          // onDaySelected: _onDaySelected,
          // onFormatChanged: ,
        ),
      ],
    );
  }

  Widget floatingButtonMore(){
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: Colors.blue,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: const Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onTap: () {  
            _awaitReturnValueFromScanner(context);
          },
          label: 'Scanner',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 16.0
          ),
          labelBackgroundColor: Colors.blue
        ),
        // FAB 2
        SpeedDialChild(
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onTap: () {  
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyNotification(),
            ));
          },
          label: 'Notifications',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0),
          labelBackgroundColor: Colors.blue
        ),
      ],
    );
  }

  void _awaitReturnValueFromScanner(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyQRScanner(),
      )
    ); 
  }
}
