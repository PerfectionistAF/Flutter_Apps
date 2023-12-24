import 'package:flutter/material.dart';
import 'package:kar_ride/screens/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kar_ride/global/global.dart';
import 'package:intl/intl.dart';

///filtered routes
///HAS A PAY BUTTON, IF PRESSED GOES TO PAY PAGE, PASS THE PRICE TO THE PAY PAGE
///IF DRIVER MARKS AS PAID, MARK DRIVER_RIDES AS PAID

//try first line from new cairo to asu
/*List<Model> startLines = [
  Model(MapLatLng(30.0074, 31.4913), MapLatLng(30.0766, 31.2845)),//to asu
  Model(MapLatLng(30.0511, 31.3656), MapLatLng(30.0766, 31.2845)),
  Model(MapLatLng(30.1123, 31.3439), MapLatLng(30.0766, 31.2845)),
  Model(MapLatLng(30.0131, 31.2089), MapLatLng(30.0766, 31.2845)), 
  ];*/
final timestamp = DateTime.now();
var format = DateFormat("HH:mm");
DateTime now = DateTime.now();
DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);

var morningRide = format.parse("07:30"); // 07:30am
var duskRide = format.parse("17:30"); // 05:30pm

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final _fireStore = FirebaseFirestore.instance;
  var isPressed = false;
  bool acceptedState = false;
  bool offeredState = false;
  bool paidState = false;
  int increment = 0;
  DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);

  final DateTime morningRide = format.parse("07:30"); // 07:30am
  var duskRide = format.parse("17:30"); // 05:30pm
  /*double searchLocationContainerHeight = 220;
  double waitingResponseForDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  //Position? userCurrentPosition;
  double bottomPaddingOfMap = 0;
  List<LatLng> coordinateList = [];

  final rnd = math.Random();
  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));*/

  @override
  Widget build(BuildContext context) {
    //bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    //AssistantMethods.readCurrentOnlineUserInfo();
    //debugPrint("This profile belongs to:\n");
    //debugPrint(currentUser!.email.toString());

    return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child:Scaffold(//check directionality:::prioritise layout, stack layout or recycler layout
              appBar: AppBar(title: Text("My Home", style: 
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
                      Icons.emoji_transportation_rounded,
                    ),
                    title: const Text('Reserve Ride'),//Reserve Ride//from routes page///change colour of polyline
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Routes");
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
              ),
            body:Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('user_rides').where('accepted', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No accepted rides at the moment');
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
                          color: Color.fromRGBO(245, 127, 23, 1)),),
                      Text(data['pickup'].toString()),
                      const Icon(Icons.arrow_forward),
                      const Text(' To ', style: 
                          TextStyle(fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(245, 127, 23, 1)),),
                      Text(data['destination'].toString()),
                    ],
                  ),
                  subtitle: (data['pickup'].toString().contains("ASU"))? 
                  Text("${duskRide.hour}:${duskRide.minute}") : Text("${morningRide.hour}:${morningRide.minute}"),
                    isThreeLine: true,
                    dense: true,
                    trailing: 
                      //mainAxisSize: MainAxisSize.min,
                      //PAYING
                        IconButton(
                          icon: Icon(
                          Icons.monetization_on_rounded,
                          color: isPressed?Colors.orange:Colors.black),

                          onPressed: () {
                            final String documentId;
                            isPressed = true;
                            if(data['paid'] == false){
                              //set new id after payment
                              if(data['pickup'].toString().contains("ASU")){
                                increment++;
                                String index = increment.toString();
                                documentId = "fromASU$index";
                              }
                              else{
                                increment++;
                                String index = increment.toString();
                                documentId = "fromASU$index";
                              }
                              _fireStore.collection('user_rides').doc(documentId).update({
                                  'paid':true,});
                            }
                            }
                        ),
                         onTap: (){
                        debugPrint(data['id']);
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=> const PaymentScreen(),
                          settings: RouteSettings(arguments: data['price'].toString()),
                          ),//send to payment page
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
            
            /*Stack(
              children: [
                SfMaps(
                  layers: [
                    MapTileLayer(
                      urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialFocalLatLng: MapLatLng(30.0766, 31.2845),
                      initialZoomLevel: 8,
                      markerBuilder: (BuildContext context, int index) {
                      
                      return MapMarker(//fixed marker for all available locations
                        latitude: startLines[index].from.latitude,
                        longitude: startLines[index].from.longitude,
                        iconType: MapIconType.circle,
                        size: Size(10, 10),
                        alignment: Alignment.center,
                        offset: Offset(0, 9),
                        iconColor: Colors.red[600],
                        iconStrokeColor: Colors.red[900],
                        iconStrokeWidth: 2,
                      );},

                      zoomPanBehavior:MapZoomPanBehavior(
                        enableDoubleTapZooming: true,
                        enablePanning: true,
                        enableMouseWheelZooming: true,
                        enablePinching: true,
                        maxZoomLevel: 20,
                        showToolbar: true,
                        zoomLevel: 10,
                      ),
                      sublayers: [
                        MapLineLayer(
                          //random colors
                          color: Colors.deepPurple[900],
                          lines: List<MapLine>.generate(
                            startLines.length,
                            (int index) {
                              return MapLine(
                                from: startLines[index].from,
                                to: startLines[index].to,
                              );
                            },
                            ).toSet(),
                            ),
                      ], 
                    ),
                  ],
                  ),
              ],
            ),*/ 
          /*),
        );
  }
}

class Model {
  Model(this.from, this.to);

  MapLatLng from;
  MapLatLng to;
}*/
}