import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';
class allColorsNotifier extends StateNotifier{
  allColorsNotifier():super('');

  getAllColors()async{
    var url = Uri.parse(baseUrl + endPointGetAllColors);
    try{
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
final colorsProvider=StateNotifierProvider((ref){
  return allColorsNotifier();
});