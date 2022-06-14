// ignore: file_names
class Person {
  late String? id;
  late String? name;
  late String? email;
  late String? password;
  late bool? adm;

  Person({this.name, this.email, this.password});

  Person.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        email = map["email"],
        password = map["password"],
        adm = map["adm"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "adm": adm,
    };
  }
}
