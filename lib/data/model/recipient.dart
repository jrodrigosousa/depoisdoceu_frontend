import 'dart:convert';

import '../../business/util.dart';

class Recipient {
  int? id;
  late String name;
  late String email;
  late String whatsapp;

  Recipient(
      {this.id,
      required this.name,
      required this.email,
      required this.whatsapp});

  Recipient.empty();

  factory Recipient.fromJson(Map<String, dynamic> json){
    Recipient recipient = Recipient.empty();
    recipient.id = json['id'].toInt();
    recipient.name = json['name'];
    recipient.email = json['email'];
    recipient.whatsapp = json['whatsapp'];
    return recipient;
  }

  String toJson() => jsonEncode({
    'id': id,
    'name': name,
    'email': email,
    'whatsapp': whatsapp,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'whatsapp': whatsapp,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipient && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}