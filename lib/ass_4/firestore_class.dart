
import 'package:cloud_firestore/cloud_firestore.dart';

class myfirestore{

  var userref = FirebaseFirestore.instance.collection('Items');

  Future<List> fetchdata()async {
    var x = await userref.get();
    List mydoc = x.docs;
    return mydoc;
  }

  AddData(){
    userref.add({'Name': 'Task', 'Deadline': 26, 'Prioritised': true});
    //userref.doc('12344567').set({'Name': 'Hala', 'Age': 60, 'Engineer': false});
  }

  EditData(){
    userref.doc('12344567').set({'Name': 'Task_edited', 'Deadline': 26, 'Prioritised': false});
    //userref.doc('12344567').update({'Engineer': true});
  }
  DeleteData(String id){
    userref.doc(id).delete();
  }


}