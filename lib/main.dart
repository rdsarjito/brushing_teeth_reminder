import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'notification.dart';
import 'scanner.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  final String  fromOtherSide;

  const MyApp({
    Key? key,
    this.fromOtherSide = ''
  }): super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String fromOtherSide = "";

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar Pengingat')),
      body: Stack(
        children: [
          calendarWidget(),
          Positioned(
            bottom: 25,
            right: 20,
            child: floatingButtonMore()
          )
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
      backgroundColor: const Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: const Icon(Icons.qr_code_scanner_rounded),
          backgroundColor: const Color(0xFF801E48),
          onTap: () {  
            _awaitReturnValueFromScanner(context);
          },
          label: 'Button 1',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 16.0
          ),
          labelBackgroundColor: const Color(0xFF801E48)
        ),
        // FAB 2
        SpeedDialChild(
          child: const Icon(Icons.circle_notifications_rounded),
          backgroundColor: const Color(0xFF801E48),
          onTap: () {  
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyNotification(),
            ));
          },
          label: 'Button 2',
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0),
          labelBackgroundColor: const Color(0xFF801E48)
        )
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
