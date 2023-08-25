import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'Services/notifi_service.dart';

DateTime scheduleTime = DateTime.now();

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Set Up'),
      ),
      body: ListView(
        children: myListMON.map((data) {
          return Container(
            padding: const EdgeInsets.all(16),
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
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(bottom: 8),
                    child:  Column(
                      children : <Widget>[
                        Expanded(
                          child: DatePickerTxt(idMON: data['idMON'])
                        ),
                        Expanded(
                          child: ScheduleBtn(idMON: data['idMON'])
                        ),
                    ]),
                  )
                ),
              ]
            ),
          );
        }).toList(),
      )
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  final int idMON;

  const DatePickerTxt({
    Key? key,
    this.idMON = 0,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {},
        );
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  final int idMON;

  const ScheduleBtn({
    Key? key,
    this.idMON = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('movieTitle: $idMON');

    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
            id: idMON,
            title: 'Scheduled Notification',
            payLoad:  '$context',
            body: '$scheduleTime',
            scheduledNotificationDateTime: scheduleTime);
      },
    );
  }
}