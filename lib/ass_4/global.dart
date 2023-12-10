import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/ass_4/user.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;//start db instance
User? currentUser;
//connect with user

UserModel? userModelCurrentInfo;