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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Set Up'),
      ),
      // body: const Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       DatePickerTxt(),
      //       ScheduleBtn(),
      //     ],
      //   ),
      // )
      body: Column(
        children: [
          dateChangerSection,
          dateChangerSection
        ],
      )

    );
  }
}

Widget dateChangerSection = Container(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue, 
        child: IconButton(
          highlightColor: Colors.blueGrey,
          icon: const Icon(
            Icons.wb_sunny_rounded,
            color: Colors.white,
            
          ),
          onPressed: () {},
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: const Text(
            'Morning',
            style: TextStyle(
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
          child: const Column(
            children : <Widget>[
              Expanded(
                child: DatePickerTxt()
              ),
              Expanded(
                child: ScheduleBtn()
              ),
          ]),
        )
      ),
    ]
  ),
);


class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
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
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
            title: 'Scheduled Notification',
            body: '$scheduleTime',
            scheduledNotificationDateTime: scheduleTime);
      },
    );
  }
}