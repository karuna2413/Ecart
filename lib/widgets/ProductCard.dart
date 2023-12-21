import 'package:flutter/material.dart';
import 'package:mangoit_ecart/provider/Provider.dart';
import 'package:mangoit_ecart/provider/authprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import 'package:mangoit_ecart/widgets/card.dart';

class ProductCard extends ConsumerStatefulWidget {
  ProductCard({super.key, required this.value, required this.color});

  String? value;
  var color;

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  var result, len, data;

  void api() async {
    var token = await ref.read(providerResult.notifier).token;

    print(token);
    var res = await ref.read(apiProvider.notifier).productApi(token);
    if (res.statusCode == 201) {
      print('successfull');
      setState(() {
        result = json.decode(res.body);
      });

      print(result);
    } else {
      print('not valid product api');
      result = json.decode(res.body);
      print(result);
    }
  }

  @override
  void initState() {
    api();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return result == null
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: result['result']['productData'].length,
            itemBuilder: (context, index) => Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: CardWidget(
                    value: widget.value,
                    color: widget.color,
                    name: result['result']['productData'][index]['name'],
                    price: result['result']['productData'][index]['price'],
                    img: result['result']['productData'][index]['path'],
                    id: result['result']['productData'][index]['id']),
              ),
            ),
          );
  }
}
