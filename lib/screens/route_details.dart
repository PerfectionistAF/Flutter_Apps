//has mapping and price of route
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:kar_ride/global/global.dart';

class RouteDetailsScreen extends StatefulWidget {
  //RouteDetailsScreen({super.key});
  const RouteDetailsScreen({super.key});
  //ScreenTwo({ @required this.data});
  //RouteDetailsScreen({required this.data});

  @override
  State<RouteDetailsScreen> createState() => _RouteDetailsScreenState();
}
List<Model> startLines = [
  Model(const MapLatLng(30.0074, 31.4913), const MapLatLng(30.0766, 31.2845)),//to asu
  Model(const MapLatLng(30.0511, 31.3656), const MapLatLng(30.0766, 31.2845)),
  Model(const MapLatLng(30.1123, 31.3439), const MapLatLng(30.0766, 31.2845)),
  Model(const MapLatLng(30.0131, 31.2089), const MapLatLng(30.0766, 31.2845)), 
  ];

class _RouteDetailsScreenState extends State<RouteDetailsScreen> {
  String? data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as String?;

    debugPrint(data); 
    return Scaffold(
      appBar: AppBar(title: const Text("My Home", style: 
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
                      color: Colors.yellow.shade900,
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
                      Icons.emoji_transportation_rounded,
                    ),
                    title: const Text('Reserve Ride'),//Reserve Ride//from routes page///change colour of polyline
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Routes");
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
    body: Stack(
              children: [
                SfMaps(
                  layers: [
                    MapTileLayer(
                      urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      initialFocalLatLng: const MapLatLng(30.0766, 31.2845),
                      initialZoomLevel: 8,
                      markerBuilder: (BuildContext context, int index) {
                      
                      return MapMarker(//fixed marker for all available locations
                        latitude: startLines[index].from.latitude,
                        longitude: startLines[index].from.longitude,
                        iconType: MapIconType.circle,
                        size: const Size(10, 10),
                        alignment: Alignment.center,
                        offset: const Offset(0, 9),
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
                    ),
                  ],
                  ),
              ],
            ),    
    );
  }
  
}
class Model {
  Model(this.from, this.to);

  MapLatLng from;
  MapLatLng to;
}


