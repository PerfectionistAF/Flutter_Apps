import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kar_ride/global/global.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';
import 'package:kar_ride/splash_screen/splash_screen.dart';

//TO DO:
/*
Authenticate with firebase con

FIX DARK THEME
HANDLE BUTTONS
CHECK TEXT IS HANDLED WELL
MAKE MARKERS FOR THE LIST OF 10 LOCATIONS
AMMEND MAPS


FIX NULL EXCEPTIONS WHEN MAP FIRST SHOWS
*/

//try first line from new cairo to asu
List<Model> lines = [
  Model(MapLatLng(30.0074, 31.4913), MapLatLng(30.0766, 31.2845))
  ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  double searchLocationContainerHeight = 220;
  double waitingResponseForDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  //Position? userCurrentPosition;
  double bottomPaddingOfMap = 0;
  List<LatLng> coordinateList = [];


  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    AssistantMethods.readCurrentOnlineUserInfo();
    debugPrint("This profile belongs to:\n");
    debugPrint(currentUser!.email.toString());

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
                      Navigator.pop(context);//ride history
                    },
                  ),
                ],
              ),
              ),
            body:Stack(
              children: [
                SfMaps(
                  layers: [
                    MapTileLayer(
                      urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialFocalLatLng: MapLatLng(30.0444, 31.2357),
                      initialZoomLevel: 8,
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
                          color: Colors.purple.shade900,
                          lines: List<MapLine>.generate(
                            lines.length,
                            (int index) {
                              return MapLine(
                                from: lines[index].from,
                                to: lines[index].to,
                              );
                            },
                            ).toSet(),
                            ),
                      ], 
                    ),
                  ],
                  ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: darkTheme? Colors.black : Colors.white, 
                backgroundColor: darkTheme? Colors.deepPurple.shade300 : Colors.amber.shade900,
                elevation: 0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                ),
                minimumSize: Size(double.infinity, 50)
                ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/Routes");
              //_submit(),
              },
              child:Text(
              'Choose Route',
              style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              ),
              ),
              ),
              ],
            ), 
          ),
        );
  }
}

class Model {
  Model(this.from, this.to);

  MapLatLng from;
  MapLatLng to;
}