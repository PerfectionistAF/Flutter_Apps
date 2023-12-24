import 'package:flutter/material.dart';
import 'package:kar_ride/screens/routes.dart';
import 'package:kar_ride/assistants/assistant_methods.dart';
import 'package:kar_ride/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _fireStore = FirebaseFirestore.instance;  
  @override
  Widget build(BuildContext context) {
   bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    AssistantMethods.readCurrentOnlineUserInfo();
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        appBar: AppBar(title: Text("Routes History", style: 
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
                    title: const Text('Reserve Ride'),//Rides History
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/Routes");//ride history
                    },
                  ),
                ],
              ),
              ),
          body:Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('user_rides').where('paid', isEqualTo: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No historical paid rides');
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