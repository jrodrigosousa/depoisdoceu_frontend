import 'package:depois_do_ceu/presentation/screen/recipients_list.dart';
import 'package:flutter/material.dart';

import '../screen/login.dart';
import '../screen/message_detail.dart';
import '../screen/messages_list.dart';
import '../screen/recipient_detail.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (context) => Login());
      case "/home":
        return MaterialPageRoute(builder: (context) => MessagesList());
      case "/recipient_list":
        return MaterialPageRoute(builder: (context) => RecipientsList());
      case "/message_detail":
        return MaterialPageRoute(builder: (context) => MessageDetail());
      case "/recipient_detail":
        return MaterialPageRoute(builder: (context) => RecipientDetail());
      default:
        return MaterialPageRoute(builder: (context) => Login());
    }
  }
}