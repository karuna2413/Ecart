import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/pages/Main_Screen.dart';
import 'package:mangoit_ecart/pages/Sign_up_page.dart';
import 'package:mangoit_ecart/theme/theme.dart';
import 'package:mangoit_ecart/provider/authprovider.dart';
import 'package:mangoit_ecart/routes/Routes.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Widget content = const SignUp();
  void api() {
    ref.read(providerResult.notifier).getToken();
  }

  @override
  void initState() {
    api();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tokenValue = ref.watch(providerResult);
    if (tokenValue != null) {
      print(tokenValue);
      content = MainScreen();
    }
    return MaterialApp(
      title: 'MangoIt-Ecart',
      theme: themedata,
      home: content,
      routes: allRoutes,
    );
  }
}
