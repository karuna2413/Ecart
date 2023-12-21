import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:mangoit_ecart/provider/authprovider.dart';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';
class UpdateAddress extends StateNotifier {
  UpdateAddress() :super([]);
  var response;

  get updatedAdd{
    return response;
  }
  updatedAddress(token,id,name,address,city,state,zipcode,country)async
  {
    var url=Uri.parse(baseUrl+endPointUpdateAddress+id.toString());
    print(url);
    var res=await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'authorization': "Bearer $token"
        },
        body: json.encode({
        'firstName':name,
        'address1':address,
        'city':city,
        'state':state,
          'postcode':zipcode,
          'country':country
        })
    );
    try{
      if(res.statusCode==201)
      {
        print('api successful update');
        response=res.body;
        state=response;

      }
    }catch(err){
      print(err);
    }
    return response;
  }
}
final updateAddressProvider=StateNotifierProvider((ref) => UpdateAddress());