import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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
DateTime timestamp = DateTime.now();
//construct 2 global arrays, ToASU and FromASU
List<Map> toASU = [];//max 10 locations
List<Map> fromASU =[];
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
      //var element = fromASU[i];
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
    return Scaffold(//);
        //appBar: AppBar(
          //centerTitle: true,
          //title: Text('Refresh Sample '),
        //),
        body: Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('locations').snapshots(),
        builder: (context, snapshot) {
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
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                    ),
                    title: Text(data['pickup'].toString()),
                    subtitle: Text(data['destination'].toString()),
                    isThreeLine: true,
                    dense: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {
                          //set that ID and document values to driver_rides
                          //add attribute driver_name
                          //change offeredState = True
                          final String documentId;
                          //offeredState = true;
                          
                          if(data['pickup'] == university['location']){
                            increment++;
                            String index = increment.toString();
                            documentId = "fromASU$index";
                            _fireStore.collection('driver_rides').doc(documentId).set({
                            //'driver_name'
                            'driver_name': "Anne",
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
                            'time': timestamp,
                            });
                          }
                          else{
                            increment++;
                            String index = increment.toString();
                            documentId = "toASU$index";
                            _fireStore.collection('driver_rides').doc(documentId).set({
                            //'driver_name'
                            'driver_name': "Benny",
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
                            'time': timestamp,
                            });
                          }
                          //ERROR
                          //debugPrint(_fireStore.collection('locations').where(, isEqualTo: True));

                        }, icon: const Icon(Icons.favorite)
                        ),//turn offered state true
                        IconButton(onPressed: () {}, icon: const Icon(Icons.paypal)),//turn paid state true in driver_rides
                        IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle)),//turn accepted state true
                        ],
                      ),
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
/*Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('locations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No locations to display');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return Container(
                  height: 300,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    data.values.toString()
                    ),
                );
              }).toList()//,map.values.toList()[index]["pic"]
            );

            //return locations.forEach((index, value) {});
            //return Row(children: [for (var cat in _fireStore.collection('locations').doc('TEST')) Text(cat.toString()) ]);
          }
        },
      ),
    ),
    );
  }
}*/

//final db = FirebaseFirestore.instance;//initialise firestore
//CollectionReference locs = FirebaseFirestore.instance.collection('locations');
/*
Future<void> _addFromASU() {
      //add a location at a time
locations.add({
            'pickup': university['location'], 
            'p_lat': university['latitude'],
            'p_long': university['longitude'],
            'destination':locations_list[0]['location'],
            'd_lat':locations_list[0]['latitude'],
          })
          .then((value) => debugPrint("Data Added"))
          .catchError((error) => debugPrint("Data couldn't be added."));
}
*/
