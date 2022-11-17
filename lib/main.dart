import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/home_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
