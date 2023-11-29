import 'dart:convert';

import 'package:depois_do_ceu/business/security.dart';
import 'package:http/http.dart' as http;

import '../../business/exception/unauthorized_login_exception.dart';
import '../../constants/config.dart';
import '../model/message.dart';

class MessageProvider {

  Future<List<dynamic>> fetchMessages() async {
      
    http.Response response = await http.get(Uri.parse('${BACKEND_URL}/messages'),
                                            headers: Security.getJwtAuthHeaders());
   
    if (response.statusCode == 200) {   
      return jsonDecode(response.body); 
    } else if (response.statusCode == 401) {   
      throw UnauthorizedLoginException('O login não foi realizado.');
    }
    else {  
      throw Exception('Failed to load the data');
    }
  }

  Future<Map<String, dynamic>> saveNewMessage(Message message)  async {
    String url = '${BACKEND_URL}/messages';
    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers.addAll(Security.getJwtAuthHeaders());

    http.Response response = await http.post(Uri.parse(url),
        body: message.toJson(),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the data');
    }
  }

  Future<Map<String, dynamic>> updateMessage(Message message)  async {
    String url = '${BACKEND_URL}/messages';
    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers.addAll(Security.getJwtAuthHeaders());

    http.Response response = await http.put(Uri.parse(url),
        body: message.toJson(),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the data');
    }
  }
}