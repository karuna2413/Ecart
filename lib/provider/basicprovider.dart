import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/Config.dart';
import '../config/endpoint.dart';
class BasicNotifier extends StateNotifier{
  BasicNotifier():super({});
  Future getData()async{
    var url = Uri.parse(baseUrl + endPointGetAllSize);
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    state = json.encode(res.body);
    return res;
  }
}
final basicprovider=FutureProvider((ref) {
  return
  BasicNotifier();
});
