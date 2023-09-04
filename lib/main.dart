import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:get/get.dart';
import 'Services//notifi_service.dart';
import 'home_page.dart';

import 'package:qr_flutter/qr_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Brushing Teeth Reminder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        period: {}
        ),
    );
  }
}