import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:kar_ride/themes/themes.dart';
//import 'package:kar_ride/main.dart';
//TO DO:
/*
Authenticate with firebase con

FIX DARK THEME
HANDLE BUTTONS
CHECK TEXT IS HANDLED WELL
*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //final emailEditText = TextEditingController();
  final phoneEditText = TextEditingController();
  final passwordEditText = TextEditingController();
  
  //Global key
  final _formKey = GlobalKey<FormState>();


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
            Column(
              children: [
                Image.asset(darkTheme ? 'assets/images/citydark.png': 'assets/images/citylight.png'),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    color: darkTheme ? Colors.deepPurpleAccent.shade400 : Colors.amber.shade900,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ////LOGIN////
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(60),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Phone',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black87 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.phone, color: Colors.blueGrey)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "can't be empty";
                                }
                                if(text.length < 2){
                                  return "please enter a valid value";
                                }
                                if(text.length > 60){
                                  return "value can't have more than 60 characters";
                                }
                                return "";//blank text
                              },
                              onChanged: (text)=>setState(() {
                                phoneEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            ///////PHONE NUMBER//////
                            
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(60),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black87 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.key, color: Colors.blueGrey)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "can't be empty";
                                }
                                if(text.length < 2){
                                  return "please enter a valid value";
                                }
                                if(text.length > 60){
                                  return "value can't have more than 60 characters";
                                }
                                return "";//blank text
                              },
                              onChanged: (text)=>setState(() {
                                passwordEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            ///////PASSWORD//////
                            
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: darkTheme? Colors.black : Colors.white, backgroundColor: darkTheme? Colors.deepPurple.shade300 : Colors.amber.shade900,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50)
                              ),
                              onPressed: (){
                                //_submit(),
                              },
                              child:Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ///LOGIN BUTTON
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){},
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: darkTheme? Colors.indigo.shade500 : Colors.yellow.shade900,
                                ),
                              ),
                            ),
                            ////FORGOT PASSWORD
                            SizedBox(height: 20,),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                  ),
                                ),
                                
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, "/Register");
                                  },
                                  child:Text(
                                    'Create an Account',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: darkTheme? Colors.indigo.shade500 : Colors.yellow.shade900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}