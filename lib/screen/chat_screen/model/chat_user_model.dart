import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  String fromId;
  String toId;
  String message;
  String read;
  String sent;
  Type type;

  Message({
    required this.fromId,
    required this.toId,
    required this.message,
    required this.read,
    required this.sent,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        fromId: json["fromId"].toString(),
        toId: json["toId"].toString(),
        message: json["message"].toString(),
        read: json["read"].toString(),
        sent: json["sent"].toString(),
        type:
            json["type"].toString() == Type.image.name ? Type.image : Type.text,
      );

  Map<String, dynamic> toJson() => {
        "fromId": fromId,
        "toId": toId,
        "message": message,
        "read": read,
        "sent": sent,
        "type": type.name,
      };
}

enum Type { text, image }
