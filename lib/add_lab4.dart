/*import 'package:flutter_application_2/main.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: mycontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  categories.add(mycontroller.text);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
