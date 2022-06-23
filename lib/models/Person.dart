// ignore: file_names
class Person {
  late String? id;
  late String? name;
  late String? email;
  late String? password;

  Person({this.name, this.email, this.password});

  Person.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        email = map["email"],
        password = map["password"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
