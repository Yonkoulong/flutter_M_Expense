import 'package:flutter/material.dart';

import '../../routes/route_names.dart';

class TripView extends StatelessWidget {
  const TripView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.AddAndEditTrip);
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Trip List'),
          ),
          body: const Text("Adding a new Trip")),
    );
  }
}
