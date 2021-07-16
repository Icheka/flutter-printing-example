import 'package:flutter/material.dart';
import 'package:plateaumed_printing_research/views/home/main.dart';
import 'package:plateaumed_printing_research/views/print/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        title: 'Printing Research',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: <String, Widget Function(BuildContext)>{
          '/': (BuildContext context) => HomeScreen(),
          '/print': (BuildContext context) => PrintScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
