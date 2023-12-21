import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';

class ApiNotifier extends StateNotifier {
  ApiNotifier() : super('');
var result;
  loginApi(Map values) async {
    var api = baseUrl + endPointLogin;
    // var client = HttpClient();
    //
    // client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => true;
    var url = Uri.parse(api);
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': values['email'],
          'password': values['password'],
        }));
    state = res;
    return res;
  }

  signupApi(Map value) async {
    var api1 = baseUrl + endPointSignup;

    final url = api1;
    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields['firstName'] = value['name'];
    request.fields['lastName'] = value['lastname'];

    request.fields['email'] = value['email'];
    request.fields['password'] = value['password'];
    var response = await request.send();
    state = response;

    return response;
  }

  forgotpassApi(email) async {
    var url = Uri.parse(baseUrl + endPointForgot);
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
        }));
    if(res.statusCode==200){
      result=json.decode(res.body);
      state = result;
      return result;
    }
    else{
      result=json.decode(res.body);
      state = result;
      return result;
    }

  }

  productApi(token) async {
    var url = Uri.parse(baseUrl + endPointProducts);
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"
      },
    );
    state = res;
    return res;
  }
}

final apiProvider = StateNotifierProvider((ref) {
  return ApiNotifier();
});
