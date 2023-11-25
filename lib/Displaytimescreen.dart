//import 'dart:convert';
//import 'main.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
//import 'package:intl/intl.dart';
//import 'world_time.dart';


class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  Map myreceiveddata = {};
  @override
  Widget build(BuildContext context) {
    myreceiveddata = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Displaying Time'),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Color.fromARGB(255, 105, 104, 104),
      body: Center(
        child: Row(
          children: [
            Center(
              child: Text(
                  "${myreceiveddata['name']} \n",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
            ),
            Center(
              child: Text(
                  "\n${myreceiveddata['time']}",
                  style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
                  ),
            ),   
          ],
        ),
      ),
    );
  }
}