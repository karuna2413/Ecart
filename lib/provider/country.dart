import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';
class CountryNotifier extends StateNotifier{
  CountryNotifier():super({});
  var response;
  get country{
    return response;
  }
  getCountry(token)async{
    var url = Uri.parse(baseUrl+endPointGetCountry);
    try{
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"

      },
    );
    if(res.statusCode==200)
      {
        print('country get successful');
        response=json.decode(res.body);
        state = response;

      }
    else{
      response=json.decode(res.body);
      print('not valid');
    }}catch(err){
      print(err);
    }
    return response;
  }
}
final countryProvider=StateNotifierProvider((ref){
  return CountryNotifier();
});