import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kar_ride/screens/home.dart';
import 'package:kar_ride/screens/register.dart';
import 'package:kar_ride/screens/login.dart';
import 'package:kar_ride/screens/routes.dart';
import 'package:kar_ride/themes/themes.dart';
import 'package:kar_ride/splash_screen/splash_screen.dart';

Future<void> main()async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      themeMode: ThemeMode.system,
      theme:Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
      routes:{
        "/Home":(context)=>HomeScreen(),
        "/Routes":(context)=>RoutesScreen(),
        "/Register":(context)=>RegisterScreen(),
        "/Login":(context)=>LoginScreen(),
      },
    );
  }
}
