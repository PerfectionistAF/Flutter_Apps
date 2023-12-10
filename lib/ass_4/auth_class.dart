import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';

class Auth{

  Sign_up() async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'sue@hotmail.com',
        password: '123456',
      );
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Updateuser()async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      final name = user.displayName;
      print("Current user is $name");
      await user.updateDisplayName("hhhhhhhhhhh");
      final name2 = user.displayName;
      print("Current user is $name2");
    }
  }


  Sign_In()async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'sue@hotmail.com',
        password: '123456',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }

  Sign_out() async{
    await FirebaseAuth.instance.signOut();
  }


}