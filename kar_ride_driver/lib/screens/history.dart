import 'package:flutter/material.dart';
import 'package:kar_ride_driver/screens/routes.dart';
import 'package:kar_ride_driver/assistants/assistant_methods.dart';
import 'package:kar_ride_driver/global/global.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
    
  @override
  Widget build(BuildContext context) {
   bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    AssistantMethods.readCurrentOnlineUserInfo();
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        appBar: AppBar(title: Text("Routes History", style: 
                TextStyle(fontFamily: 'Cairo',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,),),
                          backgroundColor:Colors.yellow.shade900),
        drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.yellow[900],//yellow.shade100 not called from const type
                      shape:BoxShape.rectangle,
                    ),
                    child: Text('User Details', style: 
                    TextStyle(fontFamily: 'Cairo',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,),),//profile details
                  ),
                  ListTile(
                    leading: Icon(
                      size:30,
                      Icons.person,
                    ),
                    title: Text(currentUser!.email.toString()),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Profile");
                    },
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: const Text('Home'),//Home//show map from home page///(later)change colour of polyline
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Home");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                    ),
                    title: const Text('Reserve Ride'),//Rides History
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Routes");//ride history
                    },
                  ),
                ],
              ),
              ),
      ),
    );
  }
}