import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/crear_grup_screen.dart';
import 'package:tusgrupos/screens/home_screen.dart';
//import 'package:tusgrupos/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());

    // TODO: implement build
  }
}
