import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../config/Config.dart';
import '../config/endpoint.dart';
import 'dart:convert';

class CartNotifier extends StateNotifier {
  CartNotifier() : super(null);
  var response;
  cartapi(customerId, productId, productVariantId, quantity, token) async {
    var url = Uri.parse(baseUrl + endPointCreateCart);

    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer $token"
          },
          body: json.encode({
            'customerId': customerId,
            'productId': productId,
            'productVariantId': productVariantId,
            'quantity': quantity,
          }));
      if(res.statusCode==401 || res.statusCode==403){
        response='unauth';
      }
      else {
        response = json.decode(res.body);
        print('cart${response}');
      }
    } catch (err) {
      print('err${err}');
    }

    state = response;
    return response;
  }
}

final cartProvider = StateNotifierProvider((ref) => CartNotifier());
