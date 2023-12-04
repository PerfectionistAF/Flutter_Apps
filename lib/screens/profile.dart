import 'package:flutter/material.dart';
import 'package:kar_ride/global/global.dart';
import 'package:kar_ride/screens/home.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';
import 'package:kar_ride/splash_screen/splash_screen.dart';

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
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
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