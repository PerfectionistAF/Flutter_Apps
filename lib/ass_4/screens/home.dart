import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("To Do List",
        style:TextStyle(
          color:Colors.white, 
          fontSize: 30),
          ),
        backgroundColor: Colors.deepPurpleAccent.shade400,
        ),
      floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent.shade400,
            child: Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/Add");
            },
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       
       body: Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No tasks to display');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                Color taskColor = Colors.blue;
                var taskPriority = data['taskPriority'];
                if (taskPriority == 'Low') {
                  taskColor = Colors.blueGrey;
                } else if (taskPriority == 'High') {
                  taskColor = Colors.red;
                }
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
                      child: CircleAvatar(
                        backgroundColor: taskColor,
                      ),
                    ),
                    title: Text(data['taskName']),
                    subtitle: Text(data['taskDate']),
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
    );
  }
}