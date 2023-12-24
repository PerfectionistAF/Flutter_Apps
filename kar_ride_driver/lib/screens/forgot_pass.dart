import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kar_ride_driver/global/global.dart';
import 'package:kar_ride_driver/screens/login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  final emailEditText = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit(){
    firebaseAuth.sendPasswordResetEmail(email: emailEditText.text.trim()
    ).then((value){
      Fluttertoast.showToast(msg: "We have sent you an email to recover password, please check your email");
    }).onError((error, stackTrace){
      Fluttertoast.showToast(msg: "Error occured:\n ${error.toString()}");
      });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        FocusScope.of(context).unfocus();
      },
      child:Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Column(
              children: [
                Image.asset('assets/images/citydark.png'),
                const SizedBox(height: 20),
                Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent.shade400 ,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ////RESET PASSWORD////
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
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.email, color: Colors.blueGrey),
                                //clear inputs
                                suffixIcon: emailEditText.text.isEmpty ? Container(width: 0) :  
                                IconButton(
                                icon:const Icon(Icons.close, color: Colors.blueGrey),
                                onPressed:(){
                                  emailEditText.clear();
                                },
                                )//only show icon when there is email
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              autofillHints: const [AutofillHints.email],//get past emails from system
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
                            
                            
                            const SizedBox(height: 20,),
                            
                            ///SUBMIT BUTTON
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:Colors.white, 
                                backgroundColor:Colors.deepPurple.shade300,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: const Size(double.infinity, 50)
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
                                'Send Reset Password Link',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 20,),
                            ////HAVE AN ACCOUNT
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Have an account?",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                  ),
                                ),
                                
                                const SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));
                                  },
                                  child:Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:Colors.indigo.shade500,
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