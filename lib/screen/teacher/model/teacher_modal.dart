// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

class Teacher {
  late final String userName;
  late final String email;
  late final String password;
  late final String phoneNumber;
  late final String field;
  late final String year;
  late final String firstName;
  late final String lastName;
  late final String about;
  late final String lastActive;
  late final String id;
  late final String pushToken;
  late final String creatAt;
  late final bool isOnline;

  Teacher({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.field,
    required this.year,
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.lastActive,
    required this.id,
    required this.pushToken,
    required this.creatAt,
    required this.isOnline,
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
        about: json['about'],
        lastActive: json['last_active'],
        id: json['id'],
        pushToken: json['push_token'],
        creatAt: json['create_at'],
        isOnline: json['is_online'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data["email"] = email;
    data["password"] = password;
    data["phoneNumber"] = phoneNumber;
    data["field"] = field;
    data["year"] = year;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data['about'] = about;
    data['last_active'] = lastActive;
    data['id'] = id;
    data['push_token'] = pushToken;
    data['create_at'] = creatAt;
    data['is_online'] = isOnline;
    return data;
  }
}
