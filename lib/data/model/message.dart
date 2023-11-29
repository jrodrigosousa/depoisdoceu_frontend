import 'dart:convert';
import '../../data/model/notification.dart' as modelNotification;

import 'package:depois_do_ceu/data/model/recipient.dart';

import '../../business/util.dart';

class Message {
  int? id;
  late String title;
  late String text;
  late DateTime toSendDate;
  late int toSendDelayInHours;
  late bool active;
  DateTime? sentDate;

  List<int> recipientIds = [];
  List<modelNotification.Notification> notifications = [];

  Message(
      {this.id,
      required this.title,
      required this.text,
      required this.toSendDate,
      required this.toSendDelayInHours,
      required this.active,
      required this.sentDate});

  factory Message.empty(){
    return Message(
      id: null,
      title: "",
      text: "",
      toSendDate: DateTime.now().add(Duration(days: 365)),
      toSendDelayInHours: 0,
      active: true,
      sentDate: null
    );
  }

  factory Message.fromJson(Map<String, dynamic> json){
    Message message = Message.empty();
    message.id = json['id'].toInt();
    message.title = json['title'];
    message.text = json['text'];
    message.toSendDate = DateTime.parse(json['toSendDate']);
    message.toSendDelayInHours = json['toSendDelayInHours'].toInt();
    message.active = json['active'];
    message.sentDate = getValueOrNUll(()=>DateTime.parse(json['sentDate']));
    message.recipientIds = json['recipientIds'].cast<int>();
    message.notifications = modelNotification.Notification.fromJsonList(json['notifications']);
    return message;
  }

  String toJson() => jsonEncode(toMap());

  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'text': text,
    'toSendDate': toSendDate.toIso8601String(),
    'toSendDelayInHours': toSendDelayInHours,
    'active': active,
    'sentDate': sentDate?.toIso8601String(),
    'recipients': recipientIds,
    'notifications': modelNotification.Notification.toMapsList(notifications),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}