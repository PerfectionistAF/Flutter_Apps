import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:kar_ride_driver/themes/themes.dart';
//import 'package:kar_ride_driver/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kar_ride_driver/global/global.dart';
import 'package:kar_ride_driver/screens/home.dart';
//TO DO:
/*
FIXED:
Validate inputs
Initialise country code
Save inputs to firebase---_submit function
Handle buttons
Check nulls and text is handled well


FIX DARK THEME
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
  bool _confirmPasswordVisible = false;
  //global key
  final _formKey = GlobalKey<FormState>();//debugging label key
  
  //initialise state of controllers as clear or not clear
  @override //override default method
  void initState(){
    super.initState();
    nameEditText.addListener(onListen);
    emailEditText.addListener(onListen);
    phoneEditText.addListener(onListen);
    addressEditText.addListener(onListen);
    passwordEditText.addListener(onListen);
    confirmpasswordEditText.addListener(onListen);
  }
  //clean up controllers to save memory
  @override
  void dispose(){
    super.dispose();//upon rebuild
    nameEditText.dispose();
    emailEditText.dispose();
    phoneEditText.dispose();
    addressEditText.dispose();
    passwordEditText.dispose();
    confirmpasswordEditText.dispose();
/////////LISTENERS
//dispose of listener in fields
    nameEditText.removeListener(onListen);
    emailEditText.removeListener(onListen);
    phoneEditText.removeListener(onListen);
    addressEditText.removeListener(onListen);
    passwordEditText.removeListener(onListen);
    confirmpasswordEditText.removeListener(onListen);
  }
  
  void onListen() => setState(() {/*update UI*/});

  void _submit() async {//to register to real time db
    if(_formKey.currentState!.validate()){//fixing null check to target error
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailEditText.text.trim(), password: passwordEditText.text.trim()
        ).then((auth) async {
          currentUser = auth.user; //authenticate current user
          if(currentUser != null){
            Map userMap = {
              "id":currentUser!.uid,
              "name":nameEditText.text.trim(),
              "email":emailEditText.text.trim(),
              "phone":phoneEditText.text.trim(),
              "address":addressEditText.text.trim()
            };//user map 
            //add it to your db
            DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
            return userRef.child(currentUser!.uid).set(userMap);
          }
          await Fluttertoast.showToast(msg: "Registered Successfully");
          Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));//if successful, go to maps
        }).catchError((errorMessage){
          Fluttertoast.showToast(msg:errorMessage.toString());
        });
    }
    else{
      debugPrint(_formKey.currentState!.validate().toString());
      Fluttertoast.showToast(msg: "Try Again");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return GestureDetector(
      //key: _formKey, ERROR ONLY ONE WIDGET SHOULD USE THIS    
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
                    color: darkTheme ? Colors.deepPurpleAccent.shade400 : Colors.yellow.shade900,
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
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///////NAME//////
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
                                prefixIcon: Icon(Icons.person, color: Colors.blueGrey),
                                //clear inputs
                                suffixIcon: nameEditText.text.isEmpty ? Container(width: 0) :  
                                IconButton(
                                icon:Icon(Icons.close, color: Colors.blueGrey),
                                onPressed:(){
                                  nameEditText.clear();
                                },)//only show icon when there is text
                              ),
                              autofillHints: [AutofillHints.name],//get past names from system
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "name field can't be empty";
                                }
                                if(text.length < 2){
                                  return "please enter a valid name";
                                }
                                if(text.length > 60){
                                  return "name can't have more than 60 characters";
                                }

                                return null;//blank--valid name, no errors
                              },
                              onChanged: (text)=>setState(() {
                                nameEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            
                            ///////EMAIL//////
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(60),
                              ],
                              keyboardType: TextInputType.emailAddress,
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
                                prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
                                //clear inputs
                                suffixIcon: emailEditText.text.isEmpty ? Container(width: 0) :  
                                IconButton(
                                icon:Icon(Icons.close, color: Colors.blueGrey),
                                onPressed:(){
                                  emailEditText.clear();
                                },
                                )//only show icon when there is email
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              autofillHints: [AutofillHints.email],//get past emails from system
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "invalid email: can't be empty";
                                }
                                if((EmailValidator.validate(text) == true) && (text.contains("eng.asu.edu.eg", 6) == true)){
                                  if(text.length > 60){
                                    return "value can't have more than 60 characters";
                                  }
                                  //validity check with @eng.asu.edu.eg
                                  return null; //valid email--no errors
                                }
                                //if not validated
                                //invalid:too short
                                if(text.length < 2){
                                  return "invalid email: please enter a valid value";
                                }
                                return "invalid email: nonexistent";//invalid:nonexistent email
                              },
                              onChanged: (text)=>setState(() {
                                emailEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),

                            ///////PHONE NUMBER//////
                            IntlPhoneField(
                              keyboardType: TextInputType.number,
                              showCountryFlag: true,
                              dropdownIcon: Icon(
                                Icons.arrow_drop_down,
                                color:Colors.blueGrey,
                              ),
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
                              ),
                              initialCountryCode: 'EG',//egypt country code
                              onChanged: (text)=>setState(() {
                                phoneEditText.text = text.completeNumber;
                              }),
                            ),
                            
                            SizedBox(height: 10,),
                            
                            ///////ADDRESS//////
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
                                prefixIcon: Icon(Icons.home, color: Colors.blueGrey),
                                //clear inputs
                                suffixIcon: addressEditText.text.isEmpty ? Container(width: 0) :  
                                IconButton(
                                icon:Icon(Icons.close, color: Colors.blueGrey),
                                onPressed:(){
                                  nameEditText.clear();
                                },
                                )//only show icon when there is address
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "address can't be empty";
                                }
                                if(text.length < 2){
                                  return "please enter a valid address";
                                }
                                if(text.length > 60){
                                  return "address can't have more than 60 characters";
                                }
                                return null;//no errors
                              },
                              onChanged: (text)=>setState(() {
                                addressEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),

                            ///////PASSWORD//////
                            TextFormField(
                              obscureText: !_passwordVisible, //make it true to hide the pass
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
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
                                prefixIcon: Icon(Icons.key, color: Colors.blueGrey),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible? Icons.visibility : Icons.visibility_off, 
                                  color: Colors.blueGrey),
                                  onPressed: (){
                                    setState(() {
                                      //update password: toggle the state whichever it lands on  
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                    ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "can't be empty";
                                }
                                if(text.length < 6){
                                  return "password should be between 6-50 characters";
                                }
                                if(text.length > 49){
                                  return "password should be less than 50 characters";
                                }
                                return null;//no errors
                              },
                              onChanged: (text)=>setState(() {
                                passwordEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 10,),

                            ///////CONFIRM PASSWORD//////
                            TextFormField(
                              obscureText: !_confirmPasswordVisible, //make it true to hide the pass
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
                                prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                                suffixIcon: IconButton(
                                  icon: Icon(_confirmPasswordVisible? Icons.visibility : Icons.visibility_off, 
                                  color: Colors.blueGrey),
                                  onPressed: (){
                                    setState(() {
                                      //update confirm password: toggle the state whichever it lands on  
                                      _confirmPasswordVisible = !_confirmPasswordVisible;
                                    });
                                  },
                                    ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isEmpty){
                                  return "can't be empty";
                                }
                                if(text != passwordEditText.text){
                                  return "passwords do not match";
                                }
                                if(text.length < 6){
                                  return "password should be between 6-50 characters";
                                }
                                if(text.length > 49){
                                  return "password should be less than 50 characters";
                                }
                                return null;//all formfields have no errors--should validate
                              },
                              onChanged: (text)=>setState(() {
                                confirmpasswordEditText.text = text;
                              }),
                            ),
                            
                            SizedBox(height: 20,),
                            

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //primary
                                backgroundColor:darkTheme? Colors.deepPurple.shade300 : Colors.yellow.shade900,
                                //onPrimary
                                foregroundColor: darkTheme? Colors.black : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50)
                              ),
                              onPressed: (){
                                debugPrint(_formKey.toString());
                                 if (_formKey.currentState!.validate()) {
                                  //differentiate between form validation and rt db
                                  //snackbar here, in db toast
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Request')),
                                    );
                                  }
                                _submit();
                              },
                              child:const Text(
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