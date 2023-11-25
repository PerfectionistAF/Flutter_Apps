import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:kar_ride/themes/themes.dart';
//import 'package:kar_ride/main.dart';
//TO DO:
/*
Validate inputs
Initialise country code
Save inputs to firebase---_submit function

FIX DARK THEME
HANDLE BUTTONS
CHECK TEXT IS HANDLED WELL
*/
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final nameEditText = TextEditingController();
  final emailEditText = TextEditingController();
  final phoneEditText = TextEditingController();
  final addressEditText = TextEditingController();
  final passwordEditText = TextEditingController();
  final confirmpasswordEditText = TextEditingController();

  bool _passwordVisible = false;
  //global key
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
                  'Register',
                  style: TextStyle(
                    color: darkTheme ? Colors.deepPurpleAccent.shade400 : Colors.amber.shade900,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
                                hintText: 'Name',
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
                                prefixIcon: Icon(Icons.person, color: Colors.blueGrey)
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
                                nameEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            ///////NAME//////
                            
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(60),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Email',
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
                                prefixIcon: Icon(Icons.email, color: Colors.blueGrey)
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
                                emailEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            ///////EMAIL//////
                            
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
                                hintText: 'Address',
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
                                prefixIcon: Icon(Icons.home, color: Colors.blueGrey)
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
                                addressEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            ///////ADDRESS//////
                            
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
                            
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(60),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
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
                                prefixIcon: Icon(Icons.lock, color: Colors.blueGrey)
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
                                confirmpasswordEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            ///////CONFIRM PASSWORD//////
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //primary
                                backgroundColor:darkTheme? Colors.deepPurple.shade300 : Colors.amber.shade900,
                                //onPrimary
                                foregroundColor: darkTheme? Colors.black : Colors.white,
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
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ///REGISTER BUTTON
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
                                  'Have an account?',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                  ),
                                ),
                                ////HAVE AN ACCOUNT////
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, "/Login");
                                  },
                                  child:Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: darkTheme? Colors.indigo.shade500 : Colors.yellow.shade900,
                                    ),
                                  ),
                                ),
                                ////CLICK TO LOGIN////
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