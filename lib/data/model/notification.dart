import 'dart:convert';

class Notification{
  int minutesBefore = 0;
  DateTime? date = DateTime.now();

  Notification();

  factory Notification.fromJson(Map<String, dynamic> json){
    Notification recipient = Notification();
    recipient.minutesBefore = json['antecedence'].toInt();
    recipient.date = DateTime.parse(json['date']);
    return recipient;
  }

  String toJson() => jsonEncode(toMap());

  Map<String, Object?> toMap() => {
    'antecedence': minutesBefore,
  };

  static List<Notification> fromJsonList(List<dynamic> lista){
    List<Notification> retorno = [];
    for(Map<String, dynamic> obj in lista){
      retorno.add(Notification.fromJson(obj));
    }
    return retorno;
  }

  static List toMapsList(List<Notification> notifications) {
    List retorno = [];
    for(Notification notification in notifications){
      retorno.add(notification.toMap());
    }
    return retorno;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Notification && other.minutesBefore == minutesBefore;
  }

  @override
  int get hashCode => minutesBefore.hashCode;
}