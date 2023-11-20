import 'package:flutter/material.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Available Routes',
                    style: TextStyle(
                      color: darkTheme ? Colors.deepPurpleAccent.shade400 : Colors.orange.shade900,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child:Row(
                    children: [
                      Icon(Icons.location_pin,color: darkTheme? Colors.deepPurple.shade800 : Colors.deepOrange.shade800,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                              color: darkTheme? Colors.deepPurple.shade800 : Colors.deepOrange.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Location 1',
                              style: TextStyle(
                              color:  Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),

                Divider(
                  height: 1,
                  thickness: 2,
                  color: darkTheme? Colors.deepPurple.shade300 : Colors.deepOrange.shade300,
                ),
                SizedBox(height: 5,),

                Padding(
                  padding: EdgeInsets.all(5),
                  child:Row(
                    children: [
                      Icon(Icons.location_pin,color: darkTheme? Colors.deepPurple.shade800 : Colors.deepOrange.shade800,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                              color: darkTheme? Colors.deepPurple.shade800 : Colors.deepOrange.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Location 2',
                              style: TextStyle(
                              color:  Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),               
              ],
            )
          ],
        ),
      ),
    );
  }
}