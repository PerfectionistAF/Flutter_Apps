import 'package:flutter/material.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';
import 'package:kar_ride/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kar_ride/screens/route_details.dart';
////retrieve the offerred rides by drivers
////either accept or not///bypass time constraint by using only offerred
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

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    //bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    AssistantMethods.readCurrentOnlineUserInfo();
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        appBar: AppBar(title: Text("Available Routes", style: 
                TextStyle(fontFamily: 'Cairo',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,),),
                          backgroundColor:Colors.yellow.shade900),
        /*drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.yellow[900],//yellow.shade100 not called from const type
                      shape:BoxShape.rectangle,
                    ),
                    child: Text('User Details', style: 
                    TextStyle(fontFamily: 'Cairo',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,),),//profile details
                  ),
                  ListTile(
                    leading: Icon(
                      size:30,
                      Icons.person,
                    ),
                    title: Text(currentUser!.email.toString()),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Profile");
                    },
                  ),
                  SizedBox(height: 20,),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: const Text('Home'),//Home//show map from home page///(later)change colour of polyline
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Home");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                    ),
                    title: const Text('Ride History'),//Rides History
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/History");//ride history
                    },
                  ),
                ],
              ),
              ),*/
        body:  Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('driver_rides').where('accepted', isEqualTo: true).snapshots(),
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
                    title: Text(data['pickup'].toString()),
                    subtitle: Text(data['driver_name'].toString()),
                    isThreeLine: true,
                    dense: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                          Icons.favorite,
                          color: isPressed?Colors.orange:Colors.black),

                          onPressed: () {
                          isPressed = true;
                          //set that ID and document values to driver_rides
                          //add attribute driver_name
                          //change offeredState = True
                          final String documentId;
                          //offeredState = true;
                          
                          if(data['accepted'] == true || data['offered']==true){
                            increment++;
                            final timestamp = DateTime.now();
                            //var now = format.parse(timestamp);
                            //var now2 = now.hour;
                            //index for document Id
                            String index = increment.toString();
                            documentId = "fromASU$index";
                            _fireStore.collection('user_rides').doc(documentId).set({
                            //'driver_name'
                            'id' : documentId,
                            'driver_name': "Anne",
                            'rider_name':"Sama",
                            'pickup': data['pickup'], 
                            'p_lat': data['p_lat'],
                            'p_long': data['p_long'],
                            'destination':data['destination'],
                            'd_lat':data['d_lat'],
                            'd_long':data['d_long'],
                            'stop_lat':data['stop_lat'],
                            'stop_long':data['stop_long'],
                            'price':data['price'],
                            'offered': true,
                            'accepted': acceptedState,
                            'paid': paidState,
                            'time_offered': timestamp,
                            });
                            //from ASU data['time_offered].add(const Duration(hours: 12));
                            if((duskRide.hour - timestamp.hour) >= 12){
                              //issue accepted color
                              //iconColor = Colors.green;
                              acceptedState = true;
                              _fireStore.collection('user_rides').doc(documentId).update({
                                'accepted':true,});
                                //isPressed = true;//USER HAS FINALLY ACCEPTED THE RIDE!!
                            }
                            //else{
                              //iconColor = Colors.red;
                            //}
                          }
                          else{
                            increment++;
                            final timestamp = DateTime.now();
                            //var now = format.parse(timestamp);
                            //var now2 = now.hour;
                            //index for document Id
                            String index = increment.toString();
                            documentId = "toASU$index";
                            _fireStore.collection('user_rides').doc(documentId).set({
                            //'driver_name'
                            'id' : documentId,
                            'driver_name': "Benny",
                            'rider_name':"Sammy",
                            'pickup': data['pickup'], 
                            'p_lat': data['p_lat'],
                            'p_long': data['p_long'],
                            'destination':data['destination'],
                            'd_lat':data['d_lat'],
                            'd_long':data['d_long'],
                            'stop_lat':data['stop_lat'],
                            'stop_long':data['stop_long'],
                            'price':data['price'],
                            'offered': true,
                            'accepted': acceptedState,
                            'paid': paidState,
                            'time_offered': timestamp,
                            });
                            //to ASU 
                            if((morningRide.hour - timestamp.hour) >= 12){
                              //issue accepted color
                              //iconColor = Colors.green;
                              acceptedState = true;
                              _fireStore.collection('driver_rides').doc(documentId).update({
                                'accepted':true,});
                                //isPressed = true;
                            }
                            //else{
                              //iconColor = Colors.red;
                            //}
                          }
                          //ERROR
                          //debugPrint(_fireStore.collection('locations').where(, isEqualTo: True));
                          setState(() {
                            isPressed = !isPressed; //turn on and off
                          });
                        }, 
                          
                        ),//turn offered state true
                  ],
                      ),
                      onTap: (){
                        debugPrint(data['id']);
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=> const RouteDetailsScreen(),
                          settings: RouteSettings(arguments: data['id']),
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
        
        /*ListView.builder(
          itemCount: route.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Text('From', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,),),
                      Text(route[index].place),
                      Icon(Icons.arrow_forward),
                      Text('To', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,),),
                      Text(uni),
                    ],
                  ),
                  subtitle: Text('Trip at 07:30 AM'),
                  trailing: ElevatedButton(
                    child: Text('Reserve', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,)),
                    onPressed: (){
                      route[index].state = true; //set state of selected ride
                      setState(() {
                        Text('Approved', style: 
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
          }),*/
                /*),
      );
  }
}

class Route {
  Route(this.place, this.state);

  String place;
  bool state;//is the route selected or not, if true show approved banner
}*/