import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mangoit_ecart/provider/authprovider.dart';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/config/endpoint.dart';

class GetSingleAddress extends StateNotifier {
  GetSingleAddress() : super([]);
  var response;

  get singleAddress {
    return response;
  }

  getSingleAddress(token, id) async {
    var url = Uri.parse('${baseUrl + endPointGetAddress}/${id}');
    print(url);
    try {
      var res = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token"
      });

      if (res.statusCode == 201) {
        print('api successful');
        response = json.decode(res.body);
        state = response;
      } else {
        response = json.decode(res.body);
        state = response;
      }
    } catch (err) {
      print(err);
    }
    return response;
  }
}

final getSingleAddressProvider =
    StateNotifierProvider((ref) => GetSingleAddress());
