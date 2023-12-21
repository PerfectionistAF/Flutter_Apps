import 'package:firebase_auth/firebase_auth.dart';
import 'package:kar_ride_driver/models/user.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;//start db instance
User? currentUser;
//connect with user

UserModel? userModelCurrentInfo;