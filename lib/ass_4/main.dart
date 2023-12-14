import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ToDoApp/screens/register.dart';
import 'package:ToDoApp/screens/login.dart';
import 'package:ToDoApp/screens/add.dart';
import 'package:ToDoApp/screens/home.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Items App',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes:{
        "/Register":(context)=>RegisterScreen(),
        "/Login":(context)=>LoginScreen(),
        "/Add":(context)=>AddScreen(),
        "/Home":(context)=>HomeScreen()
      },
    );
  }
}
