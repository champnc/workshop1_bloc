import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      home: MyHomePage('Workshop 1 with BLOC'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}

double calcDistance(double lat1, double lon1, double lat2, double lon2) {
  double r = 6371000.0;
  double d2r = Math.pi / 180.0;

  double rLat1 = lat1 * d2r;
  double rLat2 = lat2 * d2r;

  double dLat = (lat2 - lat1) * d2r;
  double dLon = (lon2 - lon1) * d2r;

  double a = (Math.sin(dLat / 2) * Math.sin(dLat / 2)) +
      (Math.cos(rLat1) *
          Math.cos(rLat2) *
          (Math.sin(dLon / 2) * Math.sin(dLon / 2)));

  double d = 2 * r * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  return d;
}

const MaterialColor kPrimaryColor = const MaterialColor(
  0xff5f4bbb,
  const <int, Color>{
    50: const Color(0xff5f4bbb),
    100: const Color(0xff5f4bbb),
    200: const Color(0xff5f4bbb),
    300: const Color(0xff5f4bbb),
    400: const Color(0xff5f4bbb),
    500: const Color(0xff5f4bbb),
    600: const Color(0xff5f4bbb),
    700: const Color(0xff5f4bbb),
    800: const Color(0xff5f4bbb),
    900: const Color(0xff5f4bbb),
  },
);
