import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';

class allCategoryNotifier extends StateNotifier{
  allCategoryNotifier():super('');
  getAllCategories() async {
    var url = Uri.parse(baseUrl + endPointGetAllCategories);
try {
  final res = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
  );
  state = res;
  return res;
}catch(err){
  print(err);
}
  }
}
final categoryProvider=StateNotifierProvider((ref){
  return allCategoryNotifier();
});