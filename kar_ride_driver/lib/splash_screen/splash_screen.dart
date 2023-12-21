import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kar_ride_driver/assistants/assistant_methods.dart';
import 'package:kar_ride_driver/global/global.dart';
import 'package:kar_ride_driver/screens/home.dart';
import 'package:kar_ride_driver/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
/*TO DO
DONE
Fix firebase assistance 
Fix timer
*/
  startTimer(){  //duration until snapshot is received
    Timer(const Duration(seconds: 5), () async {
      if(firebaseAuth.currentUser != null){
        //if current user is authenticated as non-null, call read method that creates a user model with all the info
        //else keep it as null
        firebaseAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
        
        Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));//then go to HomeScreen
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));//then go to LoginScreen
      }
        
     });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade900,
      body: Center(
        child: Text(
          'KarRide',
          style:TextStyle(
            fontFamily: 'Cairo',
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            color: Colors.grey[900],
          ),
        ),
      ),
    );
  }
}