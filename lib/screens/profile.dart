import 'package:flutter/material.dart';
import 'package:kar_ride/global/global.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AssistantMethods.readCurrentOnlineUserInfo();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("My Profile", style: 
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
                      Icons.emoji_transportation_rounded,
                    ),
                    title: const Text('Reserve Ride'),//Reserve Ride//from routes page///change colour of polyline
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Routes");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                    ),
                    title: const Text('Ride History'),//Rides History
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/History");//ride history
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                    ),
                    title: const Text('Home'),//Rides History
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Home");//home
                    },
                  ),
                ],
              ),
              ),
        body: Center(
          //padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/person.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                currentUser!.email.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}