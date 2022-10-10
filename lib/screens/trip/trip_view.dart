import 'package:flutter/material.dart';

class TripView extends StatelessWidget {
  const TripView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Add a New Trip'),
          ),
          body: const Text("Adding a new Trip")),
    );
  }
}
