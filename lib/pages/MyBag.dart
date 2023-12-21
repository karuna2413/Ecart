import 'package:flutter/material.dart';
import 'package:mangoit_ecart/widgets/addCart.dart';

class MyBag extends StatefulWidget {
  const MyBag({super.key});

  @override
  State<MyBag> createState() => _MyBagState();
}

class _MyBagState extends State<MyBag> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 30),
          child: Text(
            'My Bag',
            style: TextStyle(fontSize: 34),
          ),
        ),
        addCart(),
      ],
    );
  }
}
