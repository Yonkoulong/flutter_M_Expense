import 'package:flutter/material.dart';

class AddAndEditTrip extends StatelessWidget {
  const AddAndEditTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Add Trip'),
          ),
          body: const Text("Adding a new Trip")),
    );
  }
}
