import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';
class ShippmentNotifier extends StateNotifier{
  ShippmentNotifier():super('');
  var response;
  get shipping{
    return response;
  }
  getShippment(token)async{
    var url = Uri.parse(baseUrl+endPointGetShippment);
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"

      },
    );
    if(res.statusCode==200)
    {
      print('shipping successful');
      response=json.decode(res.body);
      state = response;

    }
    else{
      print('not valid');
    }
    return response;
  }
}
final shippingProvider=StateNotifierProvider((ref){
  return ShippmentNotifier();
});