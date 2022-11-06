// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_m_expense/models/trip_entity.dart';
import 'package:flutter_m_expense/routes/route_names.dart';

import 'package:flutter_m_expense/screens/home.dart';
import 'package:flutter_m_expense/screens/trip/add_and_edit_trip.dart';
import 'package:flutter_m_expense/screens/trip/trip_view.dart';

void main() {
  runApp(MExpense());
}

//widget
class MExpense extends StatelessWidget {
  const MExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RouteNames.Home: (context) => const Home(),
        RouteNames.TripView: (context) => const TripView(),
        RouteNames.AddAndEditTrip: (context) => AddAndEditTrip(
          theTrip: TripEntity.empty(),
        ),
      },
      initialRoute: RouteNames.Home,
    );
  }
}
