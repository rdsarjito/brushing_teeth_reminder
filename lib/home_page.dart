import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:getwidget/getwidget.dart';

import 'notification.dart';
import 'scanner.dart';

class MyHomePage extends StatefulWidget {
  final int fromOtherSide;
  final List<Map<String, dynamic>> period;
  

  const MyHomePage({
    Key? key,
    this.fromOtherSide = 0,
    required this.period
  }): super(key: key);
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> listPeriod = [
        {
      "idMON" : 0,
      "Name" : "Morning",
      "Icon": Icons.done
    },
    {
      "idMON" : 1,
      "Name" : "Night",
      "Icon": Icons.done
    },
  ];

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listPeriod.addAll(widget.period);
    // widget.fromOtherSide
    // inspect("object");
    // inspect(widget.test);
    print(inspect(listPeriod));
    return Scaffold(
      appBar: AppBar(title: const Text('Brushing Teeth Reminder')),
      body: Container(
        // padding:EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            calendarWidget(),
            Positioned(
              top: 350,
              left: 30,
              height: 200,
              width: 250,
              child: periodWidget(),
            ),
            Positioned(
              bottom: 25,
              right: 20,
              height: 50,
              width: 50,
              child: floatingButtonMore(),
            ),
          ],
        ),
      ),
    );
  }

  Widget periodWidget() {
    return Column(
      children: listPeriod.map((data) {
          return Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue, 
                  child: IconButton(
                    highlightColor: Colors.blueGrey,
                    icon: Icon(
                      data['Icon'] ,
                      // Icons.wb_sunny_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${data['Name']}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    
                  ),
                ),
              ]
            ),
          );
        }).toList(),
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
