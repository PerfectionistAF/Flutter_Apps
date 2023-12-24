import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kar_ride_driver/screens/route_details.dart';
import 'package:kar_ride_driver/global/global.dart';

//add all the routes to the collection "locations"
//first start here and select the appropriate route
List <Map<String, dynamic>> locations_list = [
  {
    'location':'15 May City',
    'latitude':29.8579,
    'longitude':31.3885,
    'stop_latitude':29.97270376687071,
    'stop_longitude':31.38835245067058,
    'price': 120
  },
  {
    'location':'Al Duqqi',
    'latitude':30.039665400749165,
    'longitude':31.205573207345545,
    'stop_latitude':30.048592859735194, 
    'stop_longitude':31.23358724103476,
    'price': 100
  },
  { 
    'location':'Maadi',
    'latitude':29.98367619830018,
    'longitude':31.31613404780419,
    'stop_latitude':30.01444301938625, 
    'stop_longitude':31.26601299921756,
    'price':140
  },
  {
    'location':'Al Matariyya',
    'latitude':30.1252529418349, 
    'longitude':31.31808543793951,
    'stop_latitude':30.09185037327099,
    'stop_longitude': 31.30670447771889,
    'price':90
  },
  {
    'location':'First New Cairo',
    'latitude':30.034262289935494, 
    'longitude':31.468473827422084,
    'stop_latitude':30.023122449784626, 
    'stop_longitude':31.364346170233997,
    'price':150
  },
  {
    'location':'Heliopolis',
    'latitude':30.107376322424674, 
    'longitude':31.34088568129912,
    'stop_latitude':30.093651060294253, 
    'stop_longitude':31.315712585077907,
    'price':80
  },
  {
    'location':'El Shorouk City',
    'latitude':30.141617967290586, 
    'longitude':31.627928991615992,
    'stop_latitude':30.087238932067738, 
    'stop_longitude':31.330357277812954,
    'price':300
  },
  {
    'location':'El Salam City',
    'latitude':30.172641617026073, 
    'longitude':31.406055526828837,
    'stop_latitude':30.10732696499171, 
    'stop_longitude':31.366102710361492,
    'price':220
  },
  {
    'location':'10 Ramadan City',
    'latitude':30.29297162591524, 
    'longitude':31.741189677828327,
    'stop_latitude':30.174127966560864, 
    'stop_longitude':31.59335518224993,
    'price':200
  },
  {
    'location':'Rod El Farag',
    'latitude':30.07732814008413, 
    'longitude':31.236809879443054,
    'stop_latitude':30.060139874167596, 
    'stop_longitude':31.245997229791197,
    'price':60
  }
];

const Map<String,dynamic> university = {
'location':"Faculty of Engineering, ASU",
'latitude':30.075808,
'longitude': 31.281116
}; 

bool acceptedState = false;
bool offeredState = false;
bool paidState = false;
int increment = 0;
final timestamp = DateTime.now();
var format = DateFormat("HH:mm");
DateTime now = DateTime.now();
DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);

var morningRide = format.parse("07:30"); // 07:30am
var duskRide = format.parse("17:30"); // 05:30pm

//back to routes page where all of the arrays are printed as lists

class LocationsRefresh extends StatefulWidget {
  const LocationsRefresh({super.key});

  @override
  State<LocationsRefresh> createState() => _LocationsRefreshState();
}

class _LocationsRefreshState extends State<LocationsRefresh> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    for(var i =0; i<10; i++){
      String index = i.toString();
      String documentId = "fromASU$index";
      _fireStore.collection('locations').doc(documentId).set({
                'pickup': university['location'], 
                'p_lat': university['latitude'],
                'p_long': university['longitude'],
                'destination':locations_list[i]['location'],
                'd_lat':locations_list[i]['latitude'],
                'd_long':locations_list[i]['longitude'],
                'stop_lat':locations_list[i]['stop_latitude'],
                'stop_long':locations_list[i]['stop_longitude'],
                'price':locations_list[i]['price'],
                'offered': offeredState,
                'accepted': acceptedState,
                'paid': paidState
              });
      String index2 = i.toString();
      String documentId2 = "toASU$index2";
      _fireStore.collection('locations').doc(documentId2).set({
              'pickup': locations_list[i]['location'], 
              'p_lat': locations_list[i]['latitude'],
              'p_long': locations_list[i]['longitude'],
              'destination':university['location'],
              'd_lat':university['latitude'],
              'd_long':university['longitude'], 
              'stop_lat':locations_list[i]['stop_latitude'],
              'stop_long':locations_list[i]['stop_longitude'],
              'price':locations_list[i]['price'],
              'offered': offeredState,
              'accepted': acceptedState,
              'paid': paidState
              });
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Available Locations", style: 
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
                  ListTile(
                    leading: const Icon(
                      Icons.place,
                    ),
                    title: const Text('My Routes'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Routes");
                    },
                  ),
                ],
              ),
              ),
        body: Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('locations').snapshots(),
        builder: (context, snapshot) {
          var isPressed = false;
          if (!snapshot.hasData) {
            return const Text('No locations to display');
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
                      width: 10,
                      height: 50,
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
                  subtitle: (data['pickup'].toString()==university['location'].toString())? 
                  Text("${duskRide.hour}:${duskRide.minute}") : Text("${morningRide.hour}:${morningRide.minute}"),
                  isThreeLine: true,
                    dense: true,
                    trailing: IconButton(
                      onPressed: (){
                          isPressed = true;
                          //set that ID and document values to driver_rides
                          //add attribute driver_email
                          //change offeredState = True
                          final String documentId;
                          offeredState = true;
                          
                          if(data['pickup'] == university['location']){
                            increment++;
                            final timestamp = DateTime.now();
                            //var now = format.parse(timestamp);
                            //var now2 = now.hour;
                            //index for document Id
                            String index = increment.toString();
                            documentId = "fromASU$index";
                            _fireStore.collection('driver_rides').doc(documentId).set({
                            //'driver_email'
                            'id' : documentId,
                            'driver_email': "Anne",
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
                            //from ASU 
                            if((duskRide.hour - timestamp.hour) <= 12){
                              acceptedState = true;
                              _fireStore.collection('driver_rides').doc(documentId).update({
                                'accepted':true,});
                                isPressed = true;
                            }
                          }
                          else{
                            increment++;
                            final timestamp = DateTime.now();
                            //var now = format.parse(timestamp);
                            //var now2 = now.hour;
                            //index for document Id
                            String index = increment.toString();
                            documentId = "toASU$index";
                            _fireStore.collection('driver_rides').doc(documentId).set({
                            //'driver_email'
                            'id' : documentId,
                            'driver_email': "Benny",
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
                            if((morningRide.hour - timestamp.hour) <= 12){
                              acceptedState = true;
                              _fireStore.collection('driver_rides').doc(documentId).update({
                                'accepted':true,});
                              isPressed = true;
                            }
                          }
                          setState(() {
                            isPressed = !isPressed;
                             //turn on and off
                          });
                        },
                        icon:Icon(
                          Icons.favorite,
                          color: isPressed?Colors.deepPurpleAccent[400]:Colors.black
                          ),  
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
    );
  }
}

String getDocument(String documentId, context){
  Navigator.pushReplacementNamed(context, "/Routes");
  return documentId;
}