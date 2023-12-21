import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';
class StateCityNotifier extends StateNotifier{
  StateCityNotifier():super('');
  var response;
  get stateCity{
    return response;
  }
  getState(token,id)async{
    var url = Uri.parse(baseUrl+endPointGetState+id);
    print(url);
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"

      },
    );
    if(res.statusCode==200)
    {
      print('state successful');
      response=json.decode(res.body);
      state = response;

    }
    else{
      print('not valid');
    }
    return response;
  }
}
final stateProvider=StateNotifierProvider((ref){
  return StateCityNotifier();
});