import 'package:firebase_database/firebase_database.dart';
import 'package:kar_ride/global/global.dart';
import 'package:kar_ride/models/user.dart';

class AssistantMethods{

  static void readCurrentOnlineUserInfo() async {
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
    .ref()
    .child('users')
    .child(currentUser!.uid);

    userRef.once().then((snap) {
      if(snap.snapshot.value != null){  //create a user model if snapshot has a value
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}