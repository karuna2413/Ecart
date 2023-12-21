import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mangoit_ecart/config/Config.dart';
import 'dart:convert';

import 'package:mangoit_ecart/config/endpoint.dart';

class CancleOrderStateNotifier extends StateNotifier {
  CancleOrderStateNotifier() : super({});

  var response;
  cnclOrder(id, token) async {
    var url = Uri.parse('${baseUrl + endPointCancleOrder}/${id}');

    print(url);
    try {
     final res = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"
      });
      if(res.statusCode==200){
        print('order cancle ');
        response = json.decode(res.body);
        state = response;
      }
      response = json.decode(res.body);
      state = response;
    } catch (err) {
      response = err;
    }
    return response;
  }
}

final cancleOrderProvider =
StateNotifierProvider((ref) => CancleOrderStateNotifier());
