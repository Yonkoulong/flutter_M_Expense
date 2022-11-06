// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../routes/route_names.dart';
import '../../models/trip_entity.dart';
import '../../sqflite/database_helper.dart';
import '../trip/add_and_edit_trip.dart';
import '../trip/add_and_edit_trip.dart';

class TripView extends StatefulWidget {
  const TripView({Key? key}) : super(key: key);

  @override
  _TripViewState createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new AddAndEditTrip(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Trip List'),
      ),
      body: FutureBuilder<List<TripEntity>>(
          future: DatabaseHelper.instance.getTrips(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TripEntity>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('No Trip in List. '))
                : ListView(
                    children: snapshot.data!.map((trip) {
                      return Center(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddAndEditTrip(theTrip: trip),
                                ));
                          },
                          leading: CircleAvatar(child: Text('${trip.id}')),
                          title: Text(trip.tripName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              )),
                        ),
                      );
                    }).toList(),
                  );
          }),
    ));
  }
}
