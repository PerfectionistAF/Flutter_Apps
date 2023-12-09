import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class myfirestore{

  var userref = FirebaseFirestore.instance.collection('UsersCollection');

  Future<List> fetchdata()async {
    var x = await userref.get();
    List mydoc = x.docs;
    return mydoc;
  }

  AddData(){
    userref.add({'Name': 'Doaa', 'Age': 26, 'Engineer': true});
    userref.doc('12344567').set({'Name': 'Hala', 'Age': 60, 'Engineer': false});
  }

  EditData(){
    userref.doc('12344567').set({'Name': 'Jana', 'Age': 77, 'Engineer': false});
    userref.doc('12344567').update({'Engineer': true});
  }
  DeleteData(String id){
    userref.doc(id).delete();
  }


}