import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kar_ride_driver/screens/home.dart';
import 'package:kar_ride_driver/screens/register.dart';
import 'package:kar_ride_driver/screens/login.dart';
import 'package:kar_ride_driver/screens/routes.dart';
import 'package:kar_ride_driver/screens/history.dart';
import 'package:kar_ride_driver/screens/profile.dart';
import 'package:kar_ride_driver/screens/pay.dart';
import 'package:kar_ride_driver/screens/forgot_pass.dart';
import 'package:kar_ride_driver/themes/themes.dart';
import 'package:kar_ride_driver/splash_screen/splash_screen.dart';
import 'package:kar_ride_driver/global/locations.dart';
import 'package:kar_ride_driver/firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //import firebase.options file
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver App',
      themeMode: ThemeMode.system,
      theme:Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LocationsRefresh(),
      routes:{
        "/Home":(context)=>HomeScreen(),
        "/Profile":(context)=>ProfileScreen(),
        "/Routes":(context)=>RoutesScreen(),
        "/History":(context)=>HistoryScreen(),
        "/Pay":(context)=>PaymentScreen(),
        "/Register":(context)=>RegisterScreen(),
        "/Login":(context)=>LoginScreen(),
        "/ForgotPassword":(context)=>ForgotPasswordScreen(),
      },
    );
  }
}
