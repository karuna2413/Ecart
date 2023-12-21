import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mangoit_ecart/config/Config.dart';
import 'dart:convert';

import 'package:mangoit_ecart/config/endpoint.dart';

class OrderInfoStateNotifier extends StateNotifier {
  OrderInfoStateNotifier() : super({});
  var res;
  var response;
  order(id, token) async {
    var url = Uri.parse('${baseUrl + endPointUserOrderDetail}/${id}');
    print(url);
    try {
      res = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"
      });

      response = json.decode(res.body);
      state = response;
    } catch (err) {
      response = err;
    }
    return response;
  }
}

final orderInfoProvider =
    StateNotifierProvider((ref) => OrderInfoStateNotifier());
