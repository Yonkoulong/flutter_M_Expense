// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Explore Beauty Of Journey",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold)),
                Text(
                  "Everything you can imagine, is here",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
