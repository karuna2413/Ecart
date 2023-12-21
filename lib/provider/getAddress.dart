import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:mangoit_ecart/provider/authprovider.dart';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';
class GetAddress extends StateNotifier {
  GetAddress() :super([]);
  var response;

get address{
  return response;
}
  getAddress(token)async{

    var url=Uri.parse(baseUrl+endPointGetAddress);
    print(url);
    var res=await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'authorization': "Bearer $token"
        }
    );
    try{
          if(res.statusCode==201)
      {
        print('api successful');
        response=json.decode(res.body);


      }
    }catch(err){
      print(err);
    }
    return response;
  }
}
final getAddressProvider=StateNotifierProvider((ref) => GetAddress());