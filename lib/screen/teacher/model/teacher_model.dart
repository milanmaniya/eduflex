import 'dart:convert';

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

class Teacher {
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String password;
  String fieldValue;
  String yearValue;
  bool isOnline;
  String createAt;
  String image;
  String pushToken;
  String id;
  String about;

  Teacher({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.fieldValue,
    required this.yearValue,
    required this.isOnline,
    required this.createAt,
    required this.image,
    required this.pushToken,
    required this.id,
    required this.about,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        fieldValue: json["fieldValue"],
        yearValue: json["yearValue"],
        isOnline: json["isOnline"],
        createAt: json["createAt"],
        image: json["image"],
        pushToken: json["pushToken"],
        id: json["id"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "fieldValue": fieldValue,
        "yearValue": yearValue,
        "isOnline": isOnline,
        "createAt": createAt,
        "image": image,
        "pushToken": pushToken,
        "id": id,
        "about": about,
      };
}
