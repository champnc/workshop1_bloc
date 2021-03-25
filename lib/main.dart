import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:intl/intl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop1_bloc/bloc/hospital_bloc.dart';
import 'package:workshop1_bloc/model/data_provider.dart';
import 'package:workshop1_bloc/model/hospital.dart';
import 'package:workshop1_bloc/model/my_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(95, 75, 187, 1),
      ),
      home: BlocProvider(
          create: (context) => HospitalBloc(),
          child: MyHomePage('Workshop 1 with BLOC')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(this.title);
  final String title;
  final _MyLocation = MyLocation(13.723884, 100.529435);
  List<Hospital> _AllHospitals = DataProvider().hospitals;

  @override
  Widget build(BuildContext context) {
    _AllHospitals.forEach((element) {
      element.distance = calcDistance(_MyLocation.latitude,
          _MyLocation.longitude, element.latitude, element.longitude);
    });
    _AllHospitals.sort((a, b) => a.distance.compareTo(b.distance));
    var closest = _AllHospitals.first;
    var furthest = _AllHospitals.last;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Location',
              style: TextStyle(
                  color: Color.fromRGBO(95, 75, 187, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Latitude : ' + _MyLocation.latitude.toString(),
              style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Longitude : ' + _MyLocation.longitude.toString(),
              style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              color: Color.fromRGBO(95, 75, 187, 1),
              minWidth: 200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClosestHospitalRoute(closest)),
                );
              },
              child: Text(
                "Closest Hospital",
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Color.fromRGBO(95, 75, 187, 1),
              minWidth: 200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FurthestHospitalRoute(furthest)),
                );
              },
              child: Text(
                "Furtest Hospital",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClosestHospitalRoute extends StatelessWidget {
  final Hospital closest;
  ClosestHospitalRoute(this.closest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            color: Color.fromRGBO(95, 75, 187, 1),
            child: Center(
              child: Text(closest.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("asset/images/resources_marker.png")),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    closest.address,
                    style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
                  ),
                ))
              ],
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("asset/images/resources_phone.png")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    closest.tel,
                    style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("asset/images/resources_road.png")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    closest.distance.toStringAsFixed(0) + " m.",
                    style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Color.fromRGBO(95, 75, 187, 1),
          )),
        ],
      ),
    );
  }
}

class FurthestHospitalRoute extends StatelessWidget {
  final Hospital furthest;
  FurthestHospitalRoute(this.furthest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            color: Color.fromRGBO(95, 75, 187, 1),
            child: Center(
              child: Text(furthest.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("asset/images/resources_marker.png")),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    furthest.address,
                    style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
                  ),
                )),
              ],
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("asset/images/resources_phone.png")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    furthest.tel,
                    style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset("asset/images/resources_road.png")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    furthest.distance.toStringAsFixed(0) + " m.",
                    style: TextStyle(color: Color.fromRGBO(95, 75, 187, 1)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Color.fromRGBO(95, 75, 187, 1),
          )),
        ],
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
