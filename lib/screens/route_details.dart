//has mapping and price of route
import 'package:flutter/material.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';
import 'package:kar_ride/global/global.dart';
import 'package:kar_ride/screens/routes.dart';

class RouteDetailsScreen extends StatefulWidget {
  //RouteDetailsScreen({super.key});
  const RouteDetailsScreen({super.key});
  //ScreenTwo({ @required this.data});
  //RouteDetailsScreen({required this.data});

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  String? data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as String?;

    debugPrint(data); 
    return const Scaffold(
           
    );
  }
}


