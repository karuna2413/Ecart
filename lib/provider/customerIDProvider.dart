import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerIdNotifier extends StateNotifier{
  CustomerIdNotifier():super(null);
   getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    state = id;

  }
  get getId async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    return id;
  }
}
final CustomerIdProvider=StateNotifierProvider((ref) => CustomerIdNotifier());