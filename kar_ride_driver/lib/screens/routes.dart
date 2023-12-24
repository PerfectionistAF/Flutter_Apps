import 'package:flutter/material.dart';
import 'package:kar_ride_driver/assistants/assistant_methods.dart';
import 'package:kar_ride_driver/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kar_ride_driver/screens/route_details.dart';
//retrieve from locations class
bool acceptedState = false;
bool offeredState = false;
bool paidState = false;
int increment = 0;
final timestamp = DateTime.now();
var format = DateFormat("HH:mm");

var morningRide = format.parse("07:30"); // 07:30am
var duskRide = format.parse("17:30"); // 05:30pm
Color iconColor = Colors.blueGrey;
var isPressed = false;
//after route is selected in locations, show it here, change offeredState = True

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  @override
  Widget build(BuildContext context) {
    //bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final fireStore = FirebaseFirestore.instance;
    AssistantMethods.readCurrentOnlineUserInfo();
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        appBar: AppBar(title: const Text("My Routes", style: 
                TextStyle(fontFamily: 'Cairo',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,),),
                          backgroundColor:Colors.deepPurpleAccent.shade400),
        drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.shade400,
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
        body:  Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('driver_rides').where('offered', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No offered rides at the moment');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color:  Colors.blueGrey,
                        blurRadius: 5.0,
                        offset: Offset(0, 5), // shadow direction: bottom right
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                    ),
                    title: Row(
                    children: [
                      const Text('From ', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.indigo),),
                      Text(data['pickup'].toString()),
                      const Icon(Icons.arrow_forward),
                      const Text(' To ', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.indigo),),
                      Text(data['destination'].toString()),
                    ],
                  ),
                  subtitle: (data['pickup'].toString().contains("ASU"))? 
                  Text("${duskRide.hour}:${duskRide.minute}") : Text("${morningRide.hour}:${morningRide.minute}"),
                    isThreeLine: true,
                    dense: true,
                      onTap: (){
                        debugPrint(data['id']);
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=> const RouteDetailsScreen(),
                          settings: RouteSettings(arguments: data['id'].toString()),
                          ),
                          );
                        //String idDetails = getDocument(data['id'], context);
                        //function that takes all the values needed for the route details
                        //HERE: THE DRIVER SIDE
                        
                      },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    ),
    ),
    );
  }
}