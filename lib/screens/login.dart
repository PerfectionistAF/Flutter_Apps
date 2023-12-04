import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kar_ride/global/global.dart';
import 'package:kar_ride/screens/home.dart';
import 'package:kar_ride/screens/forgot_pass.dart';
//TO DO:
/*
FIXED
Authenticate with firebase con
Handle buttons
Check nulls and text is handled well

FIX DARK THEME
*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailEditText = TextEditingController();
  //final phoneEditText = TextEditingController();
  final passwordEditText = TextEditingController();
  
  //Global key
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  
  //initialise state of controllers as clear or not clear
  @override //override default method
  void initState(){
    super.initState();
    emailEditText.addListener(onListen);
    //phoneEditText.addListener(onListen);
    passwordEditText.addListener(onListen);
  }
  //clean up controllers to save memory
  @override
  void dispose(){
    super.dispose();//upon rebuild
    emailEditText.dispose();
    //phoneEditText.dispose();
    passwordEditText.dispose();
/////////LISTENERS
//dispose of listener in fields
    emailEditText.removeListener(onListen);
    //phoneEditText.removeListener(onListen);
    passwordEditText.removeListener(onListen);
  }
  
  void onListen() => setState(() {/*update UI*/});

  void _submit() async {//to register to real time db
    if(_formKey.currentState!.validate()){//fixing null check to target error
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailEditText.text.trim(), password: passwordEditText.text.trim()
        ).then((auth) async {
          currentUser = auth.user; //authenticate current user

          await Fluttertoast.showToast(msg: "Login Successful");
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
                    color: darkTheme ? Colors.deepPurpleAccent.shade400 : Colors.yellow.shade900,
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
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                            
                            SizedBox(height: 20,),
                            
                            ///LOGIN BUTTON
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: darkTheme? Colors.black : Colors.white, backgroundColor: darkTheme? Colors.deepPurple.shade300 : Colors.yellow.shade900,
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
                              child:Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ////FORGOT PASSWORD
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>ForgotPasswordScreen()));
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: darkTheme? Colors.indigo.shade500 : Colors.yellow.shade900,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: 20,),
                            ////DON'T HAVE AN ACCOUNT
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
