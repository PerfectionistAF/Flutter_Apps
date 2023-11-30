import 'package:hive_flutter/hive_flutter.dart';

class Business_Cards{
  //public hive database class

  //initialise database
  void initiatedatabase() async {
    await Hive.initFlutter();
    // await Hive.deleteBoxFromDisk('Business_Cards');
    await Hive.openBox('Business_Cards');//start hive box 
  }
  //list of cards
  List<Map<String, dynamic>> _cards = [];
  //getter for business cards box
  var _businessCards = Hive.box('Business_Cards');

  //database methods
  //refresh state method
  void _refreshItems() async {
    final data = _businessCards.keys.map((key){
      final value = _businessCards.get(key);
      return {"key":key, "fullname":value["fullname"], "company":value["company"]};
    }).toList();
    /*setState((){
      _cards = data.toList();//set the state
    });*/
  }
  //create
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _businessCards.add(newItem);
    _refreshItems(); // update the UI
  }
  //read a single item
  Map<String, dynamic> _readItem(int key) {
    final item = _businessCards.get(key);
    return item;
  }
  //update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _businessCards.put(itemKey, item);
    _refreshItems(); // Update the UI
  }
  //delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _businessCards.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    /*if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }*/
}

}