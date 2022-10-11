// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../routes/route_names.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Expense Management App"),
          ),
          body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/home.jpg"), fit: BoxFit.cover),
              ),
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Explore Beauty Of Journey",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 44.0,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.only(right: 110, top: 10),
                        child: Text(
                          "Everything you can imagine, is here",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(31, 250, 242, 242)
                                  .withOpacity(0.8),
                              foregroundColor: Colors.black87,
                              minimumSize: Size(240, 60),
                              elevation: 8,
                              shadowColor: Colors.white,
                              // padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)))),
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.TripView);
                          },
                          child: Text('Get started'))),
                ],
              ))),
    );
  }
}
