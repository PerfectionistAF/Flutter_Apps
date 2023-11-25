import 'dart:convert';
//import 'main.dart';
//import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Time{
  String? location;
  //String? description;
  String? time;
  String? url;
  Time(location, url){
    this.location = location;
    //this.description = url;
    this.url = url;
    }

  Future getTime() async{
  // Future is a placeholder value until function is complete
  try{
    var response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map myData = jsonDecode(response.body);

    DateTime currenttime = DateTime.parse(myData['datetime']);
    String locoffset = myData['utc_offset'].substring(1,3);
    print(currenttime);
    //String offset = myData['utc_offset'] == null || myData['utc_offset'].length >= 3 ? "utc offset has a problem" : myData['utc_offset'].substring(1, 3);
    
    //create object
    currenttime = currenttime.add(Duration(hours:int.parse(locoffset)));
    time = DateFormat.jm().format(currenttime).toString();

    }
    catch(e) {
    print('caught error: $e');
    time = 'Unavailable';}

    return time;
  }
}
