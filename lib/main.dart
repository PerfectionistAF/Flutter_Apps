import 'package:flutter/material.dart';
import 'package:kar_ride/screens/home.dart';
import 'package:kar_ride/screens/register.dart';
import 'package:kar_ride/themes/themes.dart';

void main() {
  runApp(MyApp());
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
    );
  }
}
