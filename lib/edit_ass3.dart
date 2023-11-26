/*import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/database_ass3.dart';

class Edit extends StatefulWidget {
  final edit_name;
  final edit_company;
  final edit_email;
  final index;
  const Edit({super.key, this.edit_name, this.edit_company, this.edit_email, this.index});
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void initState() {
    edit_name.text = widget.edit_name;
    edit_company.text = widget.edit_company;
    edit_email.text = widget.edit_email;
    super.initState();
  }

  GlobalKey<FormState> mykey = GlobalKey();
  TextEditingController edit_name = TextEditingController();
  TextEditingController edit_email = TextEditingController();
  TextEditingController edit_company = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      floatingActionButton: BackButton(),
      appBar: AppBar(
        title: Text("Edit Card", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade500,
      ),
      body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Form(
                    key: mykey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: edit_name,
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
                          controller: edit_company,
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
                          controller: edit_email,
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
                  names.removeAt(widget.index);
                  names.insert(widget.index, edit_name.text);
                  company.removeAt(widget.index);
                  company.insert(widget.index, edit_company.text);
                  emails.removeAt(widget.index);
                  emails.insert(widget.index, edit_email.text);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('Edit', style: TextStyle(color: Colors.deepPurpleAccent.shade700),),
              ),
            )
        ],
        ),
      ),
    );
  }
}*/
