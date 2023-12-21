import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mangoit_ecart/config/Config.dart';
import 'dart:convert';

import 'package:mangoit_ecart/config/endpoint.dart';

class allProductNotifier extends StateNotifier {
  allProductNotifier() : super([]);
  var data = [];
  var data1;
  var result;
  var ids;
  get product {
    return data;
  }

  getAllProducts(
      {isFirst,
      pageNo,
      id,
      check,
      selectedColor,
      selectedSize,
      start,
      end}) async {
    String param = selectedColor == null ? '' : selectedColor.join(',');
    String param1 = selectedSize == null ? '' : selectedSize.join(',');

    String param2 = id == null ? '' : id.join(',');
    var newUrl;
    if (start == null && end == null) {
      newUrl =
          '${baseUrl + endPointGetAllProducts}page=${pageNo}&pageSize=10&filter=${check}&catId=${param2}&color=${param}&size=${param1}';
    } else {
      print('prmid${param2}');
      newUrl =
          '${baseUrl + endPointGetAllProducts}page=${pageNo}&pageSize=10&filter=${check}&catId=${param2}&color=${param}&size=${param1}&price=${start},${end}';
    }

    var url = Uri.parse(newUrl);
    print(url);
    try {
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        print('data${data}');
        print('successfull api2');

        result = json.decode(res.body);
        // data=[];
        data1 = result['result']['data']['rows'];
        if (check == true) {
          if (isFirst == true) {
            data = data1;
          } else {}
        } else {
          data.addAll(data1);
        }
      }
      print('data${data}');
    } catch (err) {
      print(err);
    }

    state = data;
    return data;
  }
}

final apiGetAllProvider = StateNotifierProvider((ref) {
  return allProductNotifier();
});
