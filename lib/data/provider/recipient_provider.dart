import 'dart:convert';

import 'package:depois_do_ceu/business/security.dart';
import 'package:http/http.dart' as http;

import '../../business/exception/unauthorized_login_exception.dart';
import '../../constants/config.dart';
import '../model/recipient.dart';

class RecipientProvider {

  Future<List<dynamic>> fetchRecipients() async {
      
    http.Response response = await http.get(Uri.parse('${BACKEND_URL}/recipients'),
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

  Future<Map<String, dynamic>> saveNewRecipient(Recipient recipient)  async {
    String url = '${BACKEND_URL}/recipients';
    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers.addAll(Security.getJwtAuthHeaders());

    http.Response response = await http.post(Uri.parse(url),
        body: recipient.toJson(),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the data');
    }
  }

  Future<Map<String, dynamic>> updateRecipient(Recipient recipient)  async {
    String url = '${BACKEND_URL}/recipients';
    Map<String, String> headers = {};
    headers["Content-Type"] = "application/json";
    headers.addAll(Security.getJwtAuthHeaders());

    http.Response response = await http.put(Uri.parse(url),
        body: recipient.toJson(),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the data');
    }
  }
}