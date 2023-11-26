//data model containing all the data in the class
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Note{
  final int? id;
  final String title;
  final String description; //can have no description

  const Note({required this.title, required this.description, this.id});

  factory Note.fromJson(Map<String,dynamic> json) => Note(
    id: json['id'],//returns
    title: json['title'],
    description: json['description']
  );//convert from json

  Map<String,dynamic> toJson() => {
    'id': id,//returns
    'title': title,
    'description': description
  };//convert to json
}