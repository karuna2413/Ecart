import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class GetCartNotifier extends StateNotifier{
  GetCartNotifier():super([]);
  var response;
  get cart {
    return response;
  }
   getCart(token,id,BuildContext context)async{
    var url=Uri.parse(baseUrl+endPointUserCart+id.toString());
    print(url);
    var res=await http.get(url,
    headers: {
      'Content-Type': 'application/json',
      'authorization': "Bearer $token"
    },
    );
    try{
      if(res.statusCode==401 || res.statusCode==403)
      {
        response='token is required/login again';
        Navigator.pushNamedAndRemoveUntil(
            context, "/signup", (Route<dynamic> route) => false);
        // Navigator.pushNamed(context, '/login');
        return null;

      }
      else{
        response=json.decode(res.body);
        print(response);
      }

    }catch(err)
     {
       print(err);
     }


    state=response;
    return response;

  }
}
final getCartProvider=StateNotifierProvider((ref) => GetCartNotifier());