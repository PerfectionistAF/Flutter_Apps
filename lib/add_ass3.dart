import 'package:flutter_application_2/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Add extends StatefulWidget {
  const Add({super.key});
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController add_name = TextEditingController();
  TextEditingController add_email = TextEditingController();
  TextEditingController add_company = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      floatingActionButton: BackButton(),
      appBar: AppBar(
        title: Text("Add Card", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade500,
      ),
      body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: add_name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('required name');
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Full name',
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: add_company,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('required company');
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Company',
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: add_email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('required email');
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  names.add(add_name.text);
                  emails.add(add_email.text);
                  company.add(add_company.text);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('Add'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
