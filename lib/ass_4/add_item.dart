import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  @override
  State<AddScreen> createState() => _AddScreenState();
}

List <String>tasks=[];
class _AddScreenState extends State<AddScreen> {
  TextEditingController taskcontroller = TextEditingController();
  TextEditingController prioritycontroller = TextEditingController();
  TextEditingController deadlinecontroller = TextEditingController();

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
                controller: taskcontroller,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: prioritycontroller,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: deadlinecontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  tasks.add(taskcontroller.text);
                  Navigator.pushReplacementNamed(context, '/Home');
                },
                child: Text('AddScreen'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
