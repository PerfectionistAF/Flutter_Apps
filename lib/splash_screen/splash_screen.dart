import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';
import 'package:kar_ride/global/global.dart';
import 'package:kar_ride/screens/home.dart';
import 'package:kar_ride/screens/login.dart';

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
    Timer(Duration(seconds: 3), () async {
      if(await firebaseAuth.currentUser != null){
        //if current user is authenticated as non-null, call read method that creates a user model with all the info
        //else keep it as null
        firebaseAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
        
        Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));//then go to HomeScreen
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));//then go to LoginScreen
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
          ),
        ),
      ),
    );
  }
}