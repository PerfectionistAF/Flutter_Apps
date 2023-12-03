import 'package:firebase_auth/firebase_auth.dart';
import 'package:kar_ride/models/user.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;//start db instance
User? currentUser;
//connect with user

UserModel? userModelCurrentInfo;