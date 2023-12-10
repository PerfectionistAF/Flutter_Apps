import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_2/ass_4/firestore_class.dart';
import 'auth_class.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final nameEditText = TextEditingController();
  final emailEditText = TextEditingController();
  final passwordEditText = TextEditingController();
  
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();//debugging label key
  
  Auth myauth = Auth();
  myfirestore mydata = myfirestore();
  List mylist = [];
  
  /*void _submit() async {//to register to real time db
    if(_formKey.currentState!.validate()){//fixing null check to target error
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailEditText.text.trim(), password: passwordEditText.text.trim()
        ).then((auth) async {
          currentUser = auth.user; //authenticate current user
          if(currentUser != null){
            Map userMap = {
              "id":currentUser!.uid,
              "name":nameEditText.text.trim(),
              "email":emailEditText.text.trim()
            };//user map 
            //add it to your db
            DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
            return userRef.child(currentUser!.uid).set(userMap);
          }
          //await Fluttertoast.showToast(msg: "Registered Successfully");
          ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Registered Successfully')),
                                    );
          //Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));//if successful, go to maps
        }).catchError((errorMessage){
          //Fluttertoast.showToast(msg:errorMessage.toString());
          ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Try Again')),
                                    );
        });
    }
    else{
      debugPrint(_formKey.currentState!.validate().toString());
      //Fluttertoast.showToast(msg: "Try Again");
    }
  }*/
  
  @override
  Widget build(BuildContext context) {
    
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
                SizedBox(height: 20),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent.shade400,
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
                                fillColor: Colors.white54,
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
                                return null;
                                },
                              onChanged: (text)=>setState(() {
                                emailEditText.text = "sue@hotmail.com";
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
                                fillColor:  Colors.white54,
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
                                passwordEditText.text = "123456";
                              }),
                            ),
                            
                            SizedBox(height: 20,),
                            

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //primary
                                backgroundColor:Colors.deepPurple.shade300,
                                //onPrimary
                                foregroundColor:Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50)
                              ),
                              onPressed: ()async{
                                debugPrint(_formKey.toString());
                                 if (_formKey.currentState!.validate()) {
                                  //differentiate between form validation and rt db
                                  //snackbar here, in db toast
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Request')),
                                    );
                                  }
                                  //await myauth.Sign_In();
                                  Navigator.pushReplacementNamed(context, "/Login");
                                //_submit();

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
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.indigo.shade500,
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