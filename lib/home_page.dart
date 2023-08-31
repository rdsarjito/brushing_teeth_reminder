import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification.dart';
import 'scanner.dart';

final now = DateTime.now();

class MyHomePage extends StatefulWidget {
  final int fromOtherSide;
  final Map<String, dynamic> period;
  
  const MyHomePage({
    Key? key,
    this.fromOtherSide = 0,
    required this.period
  }): super(key: key);
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> periods = [];
  DateTime today = DateTime.now();
  DateTime choosenDate = DateTime(now.year, now.month, now.day);
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final prefs = await SharedPreferences.getInstance();
    getPrefs(prefs);
    setPrefs(prefs);
  }

  void getPrefs(prefs) {
    String? getPrefsPeriods = prefs.getString('prefsPeriods');

    if(getPrefsPeriods != null) {
      periods = List.from(json.decode(getPrefsPeriods) as List);
    }
    debugPrint("INI GET");
    print(inspect(periods));
    debugPrint("INI GET");

  }

  void setPrefs(prefs) {
    debugPrint("INI WIDGET");
    print(inspect(widget.period));
    debugPrint("INI WIDGET");
    if(widget.period.toString() == {}.toString()){
      debugPrint("HASIL NYA TRUE");
    } else {
      debugPrint("HASIL NYA FALSE");
      periods.add(widget.period);
      debugPrint("INI PUSH");
      print(inspect(periods));
      debugPrint("INI PUSH");
      String encodePrefsPeriods = json.encode(periods);
      prefs.setString('prefsPeriods', encodePrefsPeriods);
    }
  }

  void _onDaySelected(selectedDay, focusedDay) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    final test = DateTime.parse(formattedDate);
    setState(() {
      choosenDate = test;
      today = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 1),
      () => 'Data Loaded',
    );
    // periods.addAll(widget.period);
    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(choosenDate);
    // debugPrint(formattedDate);
    // widget.fromOtherSide
    // inspect("object");
    // inspect(widget.test);
    // print(inspect(widget.periods));
    return Scaffold(
      appBar: AppBar(title: const Text('Brushing Teeth Reminder')),
      body: FutureBuilder<String>(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Container(
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
          );
        }
      )
    );
  }

  Widget periodWidget() {
    // debugPrint("INI PERIODS");
    // print(inspect(periods));
    // debugPrint("INI PERIODS");
    final filterByDate = periods.where((period) => period['periodDate'].toString() == choosenDate.toString()).toList();
    // final wkwk = periods.where((period) => period['idMON'] == 1).toList();

    // print(inspect(widget.periods[{'idMON'}]));
    // print(testObject["idMON"]);
    // print(inspect(resultBydate));
    // String test = choosenDate.toString();
    print(inspect(filterByDate));

    debugPrint("period");
    // print(decodedMap);
    return Column(
      children: filterByDate.map((data) {
          return Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue, 
                  child: IconButton(
                    highlightColor: Colors.blueGrey,
                    icon: const Icon(
                      Icons.done,
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
          focusedDay: today,
          calendarFormat: _calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(day, today),
          onDaySelected: _onDaySelected,
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
        ),
        SizedBox(height: 0.8),
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