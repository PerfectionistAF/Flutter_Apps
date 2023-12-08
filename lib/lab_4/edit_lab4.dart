/*import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';

class Edit extends StatefulWidget {
  final myedit;
  final index;
  const Edit({super.key, this.myedit, this.index});
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void initState() {
    mycontroller.text = widget.myedit;
    super.initState();
  }

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
                  categories.removeAt(widget.index);
                  categories.insert(widget.index, mycontroller.text);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('Edit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
