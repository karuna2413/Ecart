import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mangoit_ecart/config/Config.dart';
import 'dart:convert';

import 'package:mangoit_ecart/config/endpoint.dart';

class SettingStateNotifier extends StateNotifier {
  SettingStateNotifier() : super({});

  var response;
  setting(psw1, psw2, token) async {
    var url = Uri.parse('${baseUrl + endPointUpdatePassword}');

    try {
      final res = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer $token"
          },
          body: json.encode({"oldPassword": psw1, "password": psw2}));
      if (res.statusCode == 200) {
        print('password changed');
        response = json.decode(res.body);
        print(response);
        state = response;
      }
      response = json.decode(res.body);
      print(response);

      state = response;
    } catch (err) {
      response = err;
    }
    return response;
  }
}

final settingProvider = StateNotifierProvider((ref) => SettingStateNotifier());
