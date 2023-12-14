import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ToDoApp/screens/global_properties.dart';
import 'package:ToDoApp/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final nameEditText = TextEditingController();
  final emailEditText = TextEditingController();
  final passwordEditText = TextEditingController();
  
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();//debugging label key
  
  
  void _submit() async {//to Login to real time db
    if(_formKey.currentState!.validate()){//fixing null check to target error
        await firebaseAuth.signInWithEmailAndPassword(
          email: emailEditText.text.trim(), password: passwordEditText.text.trim()
          ).then((auth) async {
            currentUser = auth.user; //authenticate current user
            ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Login Successfully')),
                                      );
            Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen())); //if successful, go to home
          }).catchError((errorMessage){
          ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Try Again')),
                                    );
        });
    }
    else{
      debugPrint(_formKey.currentState!.validate().toString());
    }
  }
  
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
                  'Login',
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
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ///Login BUTTON
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
                                    Navigator.pushReplacementNamed(context, "/Register");
                                  },
                                  child:Text(
                                    'Sign Up',
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