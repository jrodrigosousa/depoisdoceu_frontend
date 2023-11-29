import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../business/exception/unauthorized_login_exception.dart';
import '../../constants/config.dart';

class LoginProvider {

  Future<String> login(String username, String password) async {
    print("enviando rest message de login");
    Map body = {"login":username, "password": password};
    http.Response response = await http.post(Uri.parse('${BACKEND_URL}/auth/login'),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"}
    );
    print(response);
    if (response.statusCode == 200) {
      print("código 200");
      Map<String, dynamic> result = jsonDecode(response.body);
      return result['token']!;
    } else if (response.statusCode == 401) {
      print("código 401");
      throw UnauthorizedLoginException('The login wasn\'t authorized.');
    }
    else {
      print("código outro");
      throw Exception('Failed to load the data');
    }
  }
}