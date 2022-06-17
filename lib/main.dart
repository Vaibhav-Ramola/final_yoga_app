import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/screens/chart_screen.dart';
import 'package:yoga_project/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          "chart_screen": (context) => const ChartScreen(),
        },
      ),
    );
  }
}
