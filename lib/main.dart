//***APPLICATION ASSESSMENT 3:BY HIVE DATABASES_____________________________________________________________________________*/
/*import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('cards_box');
  await Hive.openBox('cards_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Cards',
      theme: ThemeData(
        primarySwatch:  Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  final _cardsBox = Hive.box('cards_box');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  // Get all items from the database
  void _refreshItems() {
    final data = _cardsBox.keys.map((key) {
      final value = _cardsBox.get(key);
      return {"key": key, "name": value["name"], "company": value['company'], "email":value['email']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      //to sort items in order from the latest to the oldest
    });
  }

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _cardsBox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  Map<String, dynamic> _readItem(int key) {
    final item = _cardsBox.get(key);
    return item;
  }

  // Update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _cardsBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _cardsBox.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Successfully')));
  }

  // TextFields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _companyController.text = existingItem['company'];
      _emailController.text = existingItem['email'];
    }

    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  //bottom :200,
                  top: 15,
                  left: 15,
                  right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListTile(
                            leading: Material( 
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back) // the arrow back icon
                                ),
                              ),                          
                            title: Center(
                              child: Text(itemKey == null ? 'Add Card' : 'Edit Card',
                              style: TextStyle(
                                color: Colors.deepPurple.shade900,
                                fontWeight: FontWeight.bold
                                ),
                                ), 
                              ),
                  
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _companyController,
                    decoration: const InputDecoration(hintText: 'Company'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new item
                      if (itemKey == null) {
                        _createItem({
                          "name": _nameController.text,
                          "company": _companyController.text,
                          "email": _emailController.text,
                        });
                      }

                      // update an existing item
                      if (itemKey != null) {
                        _updateItem(itemKey, {
                          'name': _nameController.text.trim(),
                          'company': _companyController.text.trim(),
                          'email': _emailController.text.trim(),
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _companyController.text = '';
                      _emailController.text = '';
                      

                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: Text(itemKey == null ? 'Add' : 'Edit'),
                  ),
                  
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Cards'),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No Data Inserted Yet',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  color: Colors.deepPurple.shade200,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                      title: Text(currentItem['name'].toString()),
                      subtitle: Text(currentItem['company'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit button
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showForm(context, currentItem['key'])),
                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteItem(currentItem['key']),
                          ),
                        ],
                      )),
                );
              }),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}*/
//***APPLICATION ASSESSMENT 3:BY FORMS_____________________________________________________________________________*/
import 'package:flutter_application_2/edit_ass3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/add_ass3.dart';

  //if using regular form technques
  List name = [
  'Ahmed'
  ];
  List company = [
  'Schneider'
  ];
  List email = [
  'ahmed@hotmail.com'
  ];
  
void main() async {
  runApp(MyApp()
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Cards',
      home: const MyBusinessCards(),
      debugShowCheckedModeBanner: false,
      /* FOR FORMS*/
      routes: {
        '/home': (context) => MyBusinessCards(), 
        '/add': (context) => Add(),
        //'/edit':(context) => Edit()
        }
    );
  }
}

class MyBusinessCards extends StatefulWidget {
  const MyBusinessCards({super.key});

  @override
  State<MyBusinessCards> createState() => _MyBusinessCardsState();
}

class _MyBusinessCardsState extends State<MyBusinessCards> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      //add
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/add');
          }),
      appBar: AppBar(
        title: Text("Business Cards", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade500,
      ),
      body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  title: Text(name[index]),
                  subtitle: Text(company[index]),
                  onTap: () {
                    print('you pressed on ${name[index]}');
                  },
                  //delete
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          name.removeAt(index);
                          company.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete)),
                  
                  //edit
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return Edit(edit_name: name[index], edit_company: company[index], edit_email: email[index], index: index);
                        }));
                      },
                      icon: Icon(Icons.edit)),
                ),
              ),
            );
          }),
    );
  }
}

//***APPLICATION MAIN EIGHT: LAB6:SQFLITE DBS..............................................................***/
// main.dart

/*import 'package:flutter/material.dart';
import 'db_lab6.dart';

import 'dart:async';


void main() {
  runApp(MaterialApp(
    home: const MyApp(),
    //initialRoute: '/home',
    routes: {
      '/home': (context) => MyApp()
      },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  mydatabaseclass mydb = mydatabaseclass();
  List<Map> mylist = [];

  Future Reading_Database() async {
    List<Map> response = await mydb.reading('''SELECT * FROM 'TABLE1' ''');
    mylist = [];
    mylist.addAll(response);
    setState(() {});
  }

  @override
  void initState() {
    Reading_Database();
    super.initState();
    mydb.checking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await mydb.writing('''INSERT INTO 'TABLE1' 
          ('FIRST NAME', 'SECOND NAME') VALUES ("Faculty Of Engineering","Ain Shams University") ''');
          Reading_Database();
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Welcome to my Database"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: mylist.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: IconButton(
                  onPressed: () async {
                    await mydb.updating('''UPDATE 'TABLE1' SET 
                    'FIRST NAME' = 'Ain Shams University',
                    'SECOND NAME' = 'Faculty of Engineering' WHERE ID = ${mylist[index]['ID']}
                    ''');
                    Reading_Database();
                    setState(() {});
                  },
                  icon: Icon(Icons.edit)),
              leading: IconButton(
                  onPressed: () {
                    mydb.deleting(
                        '''DELETE FROM TABLE1 WHERE ID = ${mylist[index]['ID']}''');
                    mylist.removeWhere(
                        (element) => element['ID'] == mylist[index]['ID']);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete)),
              title: Text(mylist[index]['FIRST NAME']),
              subtitle: Text(mylist[index]['SECOND NAME']),
            );
          }),
    );
  }
}*/
//***APPLICATION MAIN SEVEN: LAB5:FORMS..............................................................***/
/*import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> mykey = GlobalKey();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Hello World"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 200,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1579444741963-5ae219cfe27c?auto=format&fit=crop&q=80&w=2940&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                ),
                Form(
                    key: mykey,
                    child: Column(
                      //Note here that When you have a Column inside a ListView, the ListView will provide the Column with all of the space it needs to layout its children. This is why there is no error in this case.
                      // However, when you have a ListView inside a Column, the Column cannot provide the ListView with a size, because the ListView needs to know how much space it has to scroll before it can be laid out. This is why you will get a Rendering error(RenderBox was not laid out).
                      children: [
                        TextFormField(
                          controller: firstnamecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('set your name to be unique like you');
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'User name',
                              icon: Icon(Icons.people)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('You forgot your email');
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'email',
                              icon: Icon(Icons.email)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                ElevatedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (mykey.currentState!.validate()) {
                        print("all is good");
                        mykey.currentState!.reset();
                      }
                    }),
              ],
            ),
          )),
    );
  }
}*/
//***APPLICATION ASSESSMENT 2_____________________________________________________________________________*/
/*import 'package:flutter/material.dart';
import 'world_time.dart';
import 'Displaytimescreen.dart';

void main() {
  runApp(MaterialApp(
    title: "MyApp",
    //initialRoute: "/home",
    home: MyApp(),
    routes: {
      '/home': (context) => const MyApp(),
      '/display': (context) => const Display(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
List<Time> list = [
  Time("Egypt", 'Africa/cairo'),
  Time("Dubai", 'Asia/Dubai'),
  Time("Colombo", 'Asia/Colombo'),
  Time("Hong Kong", 'Asia/Hong_Kong')
];
//RETRIEVE SPECIFIC DATA FROM API

// List<Time> list= [];  //RETRIEVE ALL INFO FROM API

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? time = " ";
  String? location = " ";
  String? url = " ";
  //String? description = " ";

  Future<void> getData(index)async{
    Time mytime = list[index];//instance of time
    await mytime.getTime();
    time = mytime.time!; //never nullable
    location = mytime.location!;
  }

  // Future<void> buildList()async{
  //   String api = "http://worldtimeapi.org/api/timezone";
  //   var response = await get(Uri.parse(api));

  //   List myData = jsonDecode(response.body);//decode json file from data

  //   for(var i=0; i<myData.length; i++){
  //     String url = myData[i];//get the data from the API
  //     List elementSplit = myData[i].split('/');
  //     String location = elementSplit.last.toString();
  //     if(elementSplit.length >1){
  //       elementSplit.removeLast();
  //     }
  //     var elementJoined = elementSplit.join('/');
  //     String description = elementJoined.toString();
  //     list.add(Time(location, description, url));
  //     debugPrint(list[i].url);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //this.buildList();

    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("World Time App", style:
          TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold
            )
          ),
        ),
        backgroundColor: Color.fromARGB(255, 29, 179, 69),
      ),
      backgroundColor: Color.fromARGB(255, 145, 217, 164),
      body: Center(
        child:ListView.builder(itemCount: list.length, itemBuilder: (context, index)
        {
                return ListTile(
                    onTap: () async {
                      await getData(index);
                      debugPrint('you selected $location');
                      Navigator.pushNamed(context, '/display', arguments: {
                        "name": location,
                        "time": time,
                      });
                    },
                    title: Text(list[index].location.toString()),
                    subtitle: Text(list[index].url.toString()),
                    tileColor: Colors.white,
                    horizontalTitleGap: 15,
                  );
              }),
          )
    );
  }
}
*/
//***APPLICATION MAIN SIX: LAB4:HTTP..............................................................***/
/*import 'package:flutter/material.dart';
import 'MyCountry_lab4.dart';
import 'package:http/http.dart';
import 'dart:convert';

List CountryName = [];
List CountryCurrency = [];

String API = 'https://countriesnow.space/api/v0.1/countries/currency';

Future getdata() async {
  var Response = await get(Uri.parse(API));
  Map<String, dynamic> mydata = jsonDecode(Response.body);
  List data = mydata['data'];
  CountryName = data.map((e) => e['name']).toList();
  CountryCurrency = data.map((e) => e['currency']).toList();
  return CountryCurrency;
}

void main() {
  runApp(MaterialApp(
    title: "My First App",
    home: MyApp(),
    routes: {
      '/home': (context) => MyApp(),
      '/currency': (context) => Mycurrency(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: CountryName.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    print('you selected${CountryName[index]}');
                    //Navigator.pushNamed(context, '/country');
                    Navigator.pushNamed(context, '/currency', arguments: {
                      "Currency": CountryCurrency[index],
                      "Name": CountryName[index]
                    });
                  },
                  title: Text(CountryName[index]),
                  subtitle: Text(CountryCurrency[index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/
//***END OF APPLICATION MAIN FIVE: LAB4..............................................................******/

//***APPLICATION MAIN FIVE: LAB4:LISTS..............................................................***
/*import 'package:flutter_application_2/edit_lab4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/add_lab4.dart';

List categories = [
  'beauty care sector',
  'baby care sector',
  'Food and Beverage sector',
  'home appliances sector',
  'Childreen Toys sector',
  'Adult Outfits sector',
  'Teen Outfits sector'
];
void main() {
  runApp(MaterialApp(
      title: 'Alternative Products',
      home: MySectors(),
      routes: {'/home': (context) => MySectors(), '/Add': (context) => Add()}));
}

class MySectors extends StatefulWidget {
  const MySectors({super.key});

  @override
  State<MySectors> createState() => _MySectorsState();
}

class _MySectorsState extends State<MySectors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Add');
          }),
      appBar: AppBar(
        title: Text("Select your Sector"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    print('you pressed on ${categories[index]}');
                  },
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          categories.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete)),
                  title: Text(categories[index]),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return Edit(myedit: categories[index], index: index);
                        }));
                      },
                      icon: Icon(Icons.edit)),
                ),
              ),
            );
          }),
    );
  }
}
***END OF APPLICATION MAIN FIVE: LAB4..............................................................******/

//***APPLICATION MAIN FIVE: LAB3:SCREENS..............................................................***




//***APPLICATION ASSESSMENT 1_____________________________________________________________________________

//import 'package:flutter/material.dart';

List<String> currencyA = ["EGP", "USD", "EUR"];
List<String> currencyB = ["EGP", "USD", "EUR"];
String value1 = currencyA.first;
String value2 = currencyB.first;
String value = "0";
String result = "";
int usdEgp = 40;
int eurEgp = 30;
double usdEur = 40/30;

/*calculateRate(String c_A, String c_B, String v){
  double answer = double.parse(v);
  while(c_A != c_B){
    if(c_A == "USD" && c_B == "EGP"){
      answer = answer * usd_egp;
      v = answer.toString();
      return v;
    }
    if(c_A == "EGP" && c_B == "USD"){
      answer = answer / usd_egp;
      v = answer.toString();
      return v;
    }
    if(c_A == "EUR" && c_B == "EGP"){
      answer = answer * eur_egp;
      v = answer.toString();
      return v;
    }
    if(c_A == "EGP" && c_B == "EUR"){
      answer = answer / eur_egp;
      v = answer.toString();
      return v;
    }
    if(c_A == "USD" && c_B == "EUR"){
      answer = answer * usd_eur;
      v = answer.toString();
      return v;
    }
    if(c_A == "EUR" && c_B == "USD"){
      answer = answer / usd_eur;
      v = answer.toString();
      return v;
    }
  }

  return v;
}

void main(){
  runApp(MaterialApp(
    title: 'Currencyexchangeapp',
    home: Exchangeapp(),
  ));
}

class Exchangeapp extends StatefulWidget {
  Exchangeapp({super.key});

  @override
  State<Exchangeapp> createState() => _ExchangeappState();
}

class _ExchangeappState extends State<Exchangeapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar:AppBar(
        title: Text(
          "Change your Currency Today !",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange
      ) ,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              items: currencyA.map((String value)=>DropdownMenuItem
                (
                  value:value,
                  child:Text(value)
                )
              ).toList(),
              value:value1,
              onChanged: (String? value){//nullable
                setState(() {
                  value1 = value!;//make sure nullable value will not be nullable
                });
              }
            ),
            SizedBox(
              width: 200,
              child:TextField(
                decoration: InputDecoration(
                  hintText: "Enter the value: ",
                  border: OutlineInputBorder(),
                  ),
                  onChanged: (val){
                    setState(() {
                      value = val;
                    });
                  },
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  items: currencyB.map((String value)=>DropdownMenuItem
                  (
                    value:value,
                    child:Text(value)
                  )
                  ).toList(),
                  value:value2,
                  onChanged: (String? value){//nullable
                    setState(() {
                      value2 = value!;//make sure nullable value will not be nullable
                    });
                  }  
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      result = calculateRate(value1, value2, value);
                    });
                  },
                  icon: Icon(Icons.calculate_rounded),
                ),
              ],//children of row
            ),
          Container(
            decoration: BoxDecoration(
              shape:BoxShape.rectangle,
              border: Border.all(
                color: Colors.blueGrey,
                width:2,
              ),
            ),
            width:200,
            height: 60,
            margin:EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            child:Text(result),
            ),
          ],//end of column children
        ),
      ), 
    );
  }
}***END OF APPLICATION MAIN FOUR: LAB2..............................................................******/

//*************************************..............................................................*******/

//***APPLICATION MAIN FOUR: LAB2:DROP DOWN / IMGS / TEXT FEILD..............................................................***
//import 'package:flutter/material.dart';

List mylist = ['Ahmed', 'Youssef', 'Adam'];
String input = mylist.first;
String input2 = '...';
bool status = false;

/*void main() {
  runApp(const MaterialApp(
    title: 'My First App',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
          title: const Text(
            'My First App',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.access_alarm_sharp),
            onPressed: () {
              print("you have clicked");
            }),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.asset('Assets/Fish.jpeg')),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: DropdownButton(
                        value: input,
                        items: mylist.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (var x) {
                          setState(() {
                            input = x.toString();
                            if(input == 'Ahmed'){
                              status = true;
                            }
                            else{
                              status = false;
                            }
                          });
                        }),
                  ),
                  const SizedBox(
                    //here the main purpose for this SizedBox is a space of 20 pixels
                    width: 20,
                  ),
                  Text('you selected $status')
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        onChanged: (var x) {
                          setState(() {
                            input2 = x;
                          });
                        },
                      ),
                    ),
                  ),
                  Text('you are typing $input2'),
                ],
              ),
            ],
          ),
        ));
  }
}***END OF APPLICATION MAIN FOUR: LAB2..............................................................******/

/*************************************..............................................................*******/

//***APPLICATION MAIN THREE***
//import 'package:flutter/material.dart';

/*void main() => runApp(MaterialClass());//Constructor 

class MaterialClass extends StatelessWidget {
  //const MaterialClass({super.key});
  String printSymbols (String text) {
   print(text); //console
   return '~!@#%^&*() $text';
 }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APPLICATION MAIN THREE',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "APPLICATION THREE",
            style: TextStyle(color: Color.fromARGB(255, 234, 255, 0), fontSize: 18, fontFamily:"Raleway", fontWeight: FontWeight.bold),
            ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: //Align(
          //child: Text(
          //  "Welcome to the body",
          //  style: TextStyle(fontFamily: "Roboto", fontSize: 30),
          //),
        //),
        //Image.asset(
        //  "assets/images/draw.jpeg"
        //  ),
        //Icons(
          //Icons.access_alarms_rounded,
          //size:50
        //)
        IconButton(
          onPressed:(){printSymbols("------->PRESSED");},
          icon: Icon(
            Icons.access_alarm_rounded,
            size:50
          ),
          color: Colors.red,
          ),
          //child:Center(
            //child: Text(
              //printSymbols("PRESSED"),
              //style: TextStyle(fontFamily: "Roboto", fontSize: 30),
            //),
          ),
      );
  }
}***END OF APPLICATION MAIN TWO***/

/***********************************************************************************************************/




//***APPLICATION MAIN TWO***
//import 'package:flutter/material.dart';

/*void main() {
  //runApp(const MyApp());
  runApp(MaterialApp(
    title: 'My First App',
    theme: ThemeData(fontFamily: 'Raleway'),
    home: MyHomeScreen(),
  ));
}
//stateful widget MyHomeScreen
class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  // This widget is the root of your application.
  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}
class _MyHomeScreenState extends State<MyHomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        leading: Icon(Icons.account_balance),
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text('Hello World', style:TextStyle(fontFamily: 'Roboto', fontSize:30, fontWeight:FontWeight.bold)
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
        print('You clicked',);
        }, 
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("+"),
        ),
      ),
      body:Column(
        children: [
          SingleChildScrollView(
            scrollDirection:Axis.horizontal,
            child: Row(children: [
               ElevatedButton(onPressed: (){
                print("printing button");
              },
                child: Text("The Elevated Button", style:TextStyle(fontFamily: 'Roboto')),
              ),
            ],)
           //children[Image.network('')]
          //Text('Heeellllooo'),
          ),
        ],
      )
    );
}
}
***END OF APPLICATION MAIN TWO***/

/***********************************************************************************************************/

//***APPLICATION MAIN ONE***
//import 'package:flutter/material.dart';

//void main() {
//  runApp(MyApp());
//}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 13, 211, 86)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _incrementCounter,
        //mouseCursor: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
***END OF APPLICATION MAIN ONE***/

/***********************************************************************************************************/

/* DOCUMENTATION APPLICATION
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'flutter_application_2',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),  // ← Example change.,
          BigCard(pair: pair),
          //Adding a button
          ElevatedButton(
            onPressed: () {
              //print('button pressed!');
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Card(
        child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase),
        ),
    );
    //return Text(pair.asLowerCase);
  }
}
DOCUMENTATION APPLICATION*/