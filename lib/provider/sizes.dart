import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/Config.dart';
import 'package:http/http.dart' as http;

import '../config/endpoint.dart';

class allSizesNotifier extends StateNotifier {
  allSizesNotifier() : super('');
  getAllSizes() async {
    var url = Uri.parse(baseUrl + endPointGetAllSize);
    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    state = res;
    return res;
  }
}

final sizesProvider = StateNotifierProvider((ref) {
  return allSizesNotifier();
});
