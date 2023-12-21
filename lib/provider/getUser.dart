
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mangoit_ecart/config/Config.dart';
import 'dart:convert';

import 'package:mangoit_ecart/config/endpoint.dart';
class GetUserStateNotifier extends StateNotifier{
  GetUserStateNotifier():super({});
  // var res;
  var response;

  getUser(token,BuildContext context)async{
    var url=Uri.parse(baseUrl+endPointGetUser);
    try{
     var res=await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"
      } );
      if(res.statusCode==401 || res.statusCode==403){
        // final SharedPreferences prefs =
        // await SharedPreferences.getInstance();
        // await prefs.remove('token');
        Navigator.pushNamedAndRemoveUntil(
            context, "/signup", (Route<dynamic> route) => false);
        return null;

        // response='token is required/login again';
        // state=response;
      }
      else{
        response=json.decode(res.body);
        state=response;
      }


    }catch(err){
      response=err;
    }
    return response;
  }
}
final userProvider=StateNotifierProvider((ref) => GetUserStateNotifier());