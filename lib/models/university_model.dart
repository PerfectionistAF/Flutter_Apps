

class University{
  final int id;
  final String firstname;
  final int secondname;

  const University({
    required this.id,
    required this.firstname,
    required this.secondname,
  });
  // Convert into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'secondname': secondname,
    };
  }
}