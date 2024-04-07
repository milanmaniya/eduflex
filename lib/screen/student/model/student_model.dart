// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
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
  String div;
  String lastActive;
  String rollNo;
  bool fees;
  String paymentId;

  Student({
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
    required this.div,
    required this.lastActive,
    required this.rollNo,
    required this.fees,
    required this.paymentId,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
        div: json["div"],
        lastActive: json['lastActive'],
        rollNo: json['rollNo'],
        fees: json['fees'],
        paymentId: json['paymentId'],
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
        "div": div,
        "lastActive": lastActive,
        "rollNo": rollNo,
        "fees": fees,
        "paymentId": paymentId,
      };
}
