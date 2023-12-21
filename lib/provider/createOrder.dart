import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';

class CreateOrderNotifier extends StateNotifier {
  CreateOrderNotifier() : super({});
  var response;
  var subTotal;
  var grandTotal1;
  get order {
    return response;
  }

  getOrder(
      token,
      address1,
      cardNo,
      cardMonth,
      cardYear,
      cardCvv,
      city,
      country,
      customerID,
      email,
      firstname,
      grandTotal,
      phone,
      postcode,
      state,
      methodTitle,
      paymentMethod) async {
    try {
      grandTotal1 = grandTotal + 12;
      print(subTotal);
      var url = Uri.parse(baseUrl + endPointCreateOrder);
      var payload = json.encode({
        'address1': address1,
        'cardCvc': cardCvv,
        'cardMonth': cardMonth,
        'cardNumber': cardNo,
        'cardYear': cardYear,
        'city': city,
        'country': country,
        'customerId': customerID,
        'defaultAddress': "1",
        'email': email,
        'firstName': firstname,
        'grandTotal': grandTotal1,
        'isShippingSame': "true",
        'lastName': "",
        'methodTitle': methodTitle,
        'paymentMethod': paymentMethod,
        'phone': phone,
        'postcode': postcode,
        'shippingAddressId': 946,
        'shippingAmount': 12,
        'shippingDescription': "s",
        'shippingMethod': "flatrate",
        'shippingTitle': "ship",
        'state': state,
        'subTotal': grandTotal
      });

      print(payload);
      print(token);
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer $token"
          },
          body: payload);

      if (res.statusCode == 200) {
        print('order successful');
        response = json.decode(res.body);
        print('ordrres$response');
        state = response;
      } else {
        response = json.decode(res.body);
        print('errres$response');
      }
    } catch (err) {
      print(err);
      response = err;
    }

    return response;
  }
}

final orderProvider = StateNotifierProvider((ref) {
  return CreateOrderNotifier();
});
