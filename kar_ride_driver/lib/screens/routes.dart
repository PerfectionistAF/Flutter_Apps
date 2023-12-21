import 'package:flutter/material.dart';
import 'package:kar_ride_driver/assistants/assistant_methods.dart';
import 'package:kar_ride_driver/global/global.dart';
//retrieve from locations class
List<Route> route = [
  Route('New Cairo', false),
  Route('Nasr City', false),
  Route('Heliopolis', false),
  Route('Giza', false),
  ];
String uni = 'Ain Shams University';
//after route is selected in locations, show it here, change offeredState = True

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    AssistantMethods.readCurrentOnlineUserInfo();
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        appBar: AppBar(title: const Text("Available Routes", style: 
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
                    child: const Text('User Details', style: 
                    TextStyle(fontFamily: 'Cairo',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,),),//profile details
                  ),
                  ListTile(
                    leading: const Icon(
                      size:30,
                      Icons.person,
                    ),
                    title: Text(currentUser!.email.toString()),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Profile");
                    },
                  ),
                  const SizedBox(height: 20,),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    title: const Text('Home'),//Home//show map from home page///(later)change colour of polyline
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Home");
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.history,
                    ),
                    title: const Text('Ride History'),//Rides History
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/History");//ride history
                    },
                  ),
                ],
              ),
              ),
        body: ListView.builder(
          itemCount: route.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  title: Row(
                    children: [
                      const Text('From', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,),),
                      Text(route[index].place),
                      const Icon(Icons.arrow_forward),
                      const Text('To', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,),),
                      Text(uni),
                    ],
                  ),
                  subtitle: const Text('Trip at 07:30 AM'),
                  trailing: ElevatedButton(
                    child: const Text('Reserve', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,)),
                    onPressed: (){
                      route[index].state = true; //set state of selected ride
                      setState(() {
                        const Text('Approved', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,));
                      });
                    }, 
                    ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Ride Reserved Successfully')),
                                    );
                    print('Ride reserved successfully');
                    //payment page
                    Navigator.pushReplacementNamed(context, "/Pay");//ride history
                  },
                ),
              ),
            );
          }),
      ),
    );
  }
}
class Route {
  Route(this.place, this.state);

  String place;
  bool state;//is the route selected or not, if true show approved banner
}