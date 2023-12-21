import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';
class DeleteItem extends StateNotifier{
  DeleteItem():super([]);
  var response;
   deleteItem(id,token)async
  {
    var url=Uri.parse(baseUrl+endPointDeleteItem+id.toString());
    try{
    var res=await http.delete(url,
    headers: {
      'Content-Type': 'application/json',
      'authorization': "Bearer $token"
    }
    );

      if(res.statusCode==201)
      {
        print('api deleted successful');
        response=json.encode(res.body);

      }
    }catch(err){
      print(err);
    }


    return response;
  }
}
final deleteItemProvider=StateNotifierProvider((ref) => DeleteItem());