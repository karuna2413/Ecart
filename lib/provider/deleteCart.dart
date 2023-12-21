import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class DeleteCartNotifier extends StateNotifier{
  DeleteCartNotifier():super({});
  var response;

  deleteCart(token,id)async{
    var url=Uri.parse(baseUrl+endPointDeleteCart+id.toString());
    print(url);
    try{
    var res=await http.delete(url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"
      },
    );

      if(res.statusCode==200)
      {
        response=json.decode(res.body);
        print(response);
        print('cart delete ');
      }
    }catch(err){
      print(err);
    }



    return response;

  }
}
final deleteCartProvider=StateNotifierProvider((ref) => DeleteCartNotifier());