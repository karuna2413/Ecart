import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/authprovider.dart';
import '../provider/getAddress.dart';

class AddShoppingAddress extends ConsumerStatefulWidget {
  const AddShoppingAddress({super.key});

  @override
  ConsumerState<AddShoppingAddress> createState() => _AddShoppingAddressState();
}

class _AddShoppingAddressState extends ConsumerState<AddShoppingAddress> {
  late bool checkBoxValue;
  var checkBox;
  var addAddress;
  var check = [];
  var res, token;
  var isLoader = false;
  var isApply = false;
  var apiData;
  List data = [];

  void api() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await ref.read(providerResult.notifier).token;
    res = await ref.read(getAddressProvider.notifier).getAddress(token);
    data = res['result']['addressData'];
    apiData =
        data.where((element) => element['addressType'] == 'shipping').toList();
    print('res${res}');
    // print(res.runtimeType);
    print(res['result']['addressData'].length);
    if (this.mounted) {
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  void initState() {
    api();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return apiData == null || isLoader == true
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Center(child: Text('Shipping Addresses')),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Center(child: Text('Shipping Addresses')),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 15, bottom: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: apiData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${apiData[index]['firstName']}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                var value =
                                                    await Navigator.pushNamed(
                                                        context,
                                                        '/shoppingaddress',
                                                        arguments:
                                                            apiData[index]
                                                                ['id']);
                                                if (value == true) {
                                                  setState(() {
                                                    isLoader = true;
                                                    // api();
                                                  });
                                                  Timer(Duration(seconds: 2),
                                                      () => api());
                                                }
                                              },
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, right: 15),
                                      child: Text(
                                        '${apiData[index]['address1']}',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, right: 15),
                                      child: Text(
                                        '${apiData[index]['city']} ${apiData[index]['state']} ${apiData[index]['postcode']} ${apiData[index]['country']}',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          // height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            tileColor: Colors.grey,
                                            title: const Text(
                                                'Use as the shipping address',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14)),
                                            value: check.contains(index)
                                                ? checkBoxValue = true
                                                : checkBoxValue = false,
                                            onChanged: (bool? newValue) async {
                                              final SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              if (checkBoxValue) {
                                                checkBoxValue = newValue!;

                                                print(check);
                                              } else {
                                                check = [];
                                                check.contains(index)
                                                    ? check.remove(index)
                                                    : check.add(index);
                                                print(check);
                                              }
                                              isApply = true;
                                              Navigator.pop(context, {
                                                'firstName': apiData[index]
                                                    ['firstName'],
                                                'address1': apiData[index]
                                                    ['address1'],
                                                'city': apiData[index]['city'],
                                                'state': apiData[index]
                                                    ['state'],
                                                'postcode': apiData[index]
                                                    ['postcode'],
                                                'country': apiData[index]
                                                    ['country'],
                                                'email': apiData[index]
                                                    ['email'],
                                                'phone': apiData[index]['phone']
                                              });

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ));
  }
}
