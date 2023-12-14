import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final List<String> priority = ['High', 'Low']; //dropdown for task priorities 
  late String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: BackButton(
        onPressed: (){
          Navigator.pushReplacementNamed(context, '/Home');
        }
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Task",
        style:TextStyle(
          color:Colors.white, 
          fontSize: 30),
          ),
        backgroundColor: Colors.deepPurpleAccent.shade400,
      ),

       body: Center(
        child: Form(
          child: Column(
            children: <Widget>[

              //TASK TITLE
              TextFormField(
                controller: titleController,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration( 
                   icon: Icon(Icons.task), 
                   labelText: "Task Title",
                   ),
              ),
              const SizedBox(height: 15),

              //TASK DEADLINE + DATE PICKER
              TextFormField(
               controller: dateController, 
               decoration: const InputDecoration( 
                    icon: Icon(Icons.calendar_today), 
                   labelText: "Task Deadline" 
            ),
               readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                    
                    DateTime? pickedDate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = intl.DateFormat.yMMMd().format(pickedDate);
                      print(formattedDate); 
                        //you can implement different kind of Date Format

                      setState(() {
                         dateController.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                }
              ),
              const SizedBox(height: 30),

              //TASK PRIORITY DROP DOWN MENU
              Row(
                children: <Widget>[
                  const Icon(Icons.tag),
                  const SizedBox(width: 30.0),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        ' Prioritise your task',
                        style: TextStyle(fontSize: 14),
                      ),
                      
                      //menuMaxHeight: 60,
                      items: priority
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(() {
                          if (value != null) selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                      onPressed: () {
                      final taskName = titleController.text;
                      final taskDate = dateController.text;
                      final taskPriority = selectedValue;
                      _addTasks(taskName: taskName, taskDate: taskDate, taskPriority: taskPriority);
                      
                      
                      Navigator.pushReplacementNamed(context, '/Home');
                    },
                child: Text('Add'),
              ),
            )
            ],
          ),
        ),
        ),
      );
  }

  Future _addTasks({required String taskName, required String taskDate, required String taskPriority}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskName': taskName,
        'taskDate': taskDate,
        'taskPriority': taskPriority,
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    titleController.text = '';
    dateController.text = '';
  }
}