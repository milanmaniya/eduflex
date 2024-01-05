import 'dart:convert';

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

class Teacher {
  String userName;
  String email;
  String password;
  String phoneNumber;
  String field;
  String year;
  String firstName;
  String lastName;

  Teacher({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.field,
    required this.year,
    required this.firstName,
    required this.lastName,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        field: json["field"],
        year: json["year"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "field": field,
        "year": year,
        "firstName": firstName,
        "lastName": lastName,
      };
}
