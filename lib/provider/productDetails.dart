import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/config/endpoint.dart';
import 'package:http/http.dart' as http;
import '../config/Config.dart';
import 'dart:convert';
class ProductDetailNotifier extends StateNotifier{
  var response;
  ProductDetailNotifier():super(null);
   getProductDetail(id)async{
     var url = Uri.parse(baseUrl + endPointProductDetail+id);
     print(url);
     final res = await http.get(
       url,
       headers: {
         'Content-Type': 'application/json',
       },
     );
     if(res.statusCode==201)
       {
         print('api success');
         response=json.decode(res.body);
         print(response);
       }
     else{
       print('err');
     }
     state = response;
     return response;
  }
}
final productDetailProvider=StateNotifierProvider((ref) => ProductDetailNotifier());