import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/provider/getSingleAddress.dart';

import '../provider/authprovider.dart';
import '../provider/country.dart';
import '../provider/state.dart';
import '../provider/updateAddress.dart';

class ShoppingAddress extends ConsumerStatefulWidget {
  const ShoppingAddress({super.key});

  @override
  ConsumerState<ShoppingAddress> createState() => _ShoppingAddressState();
}

class _ShoppingAddressState extends ConsumerState<ShoppingAddress> {
  var id;
  var isLoader = false;
  var isFirst = true;
  void didChangeDependencies() {
    id = ModalRoute.of(context)?.settings?.arguments;
    print(id);
    if (isFirst == true && id != 'add') {
      isLoader = true;

      api();
    }
    if (id == 'add') {
      api();
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  var res, token, res1, res2;
  void api() async {
    token = await ref.read(providerResult.notifier).token;
    if (id != 'add') {
      res = await ref
          .read(getSingleAddressProvider.notifier)
          .getSingleAddress(token, id);

      if (this.mounted) {
        setState(() {
          isLoader = false;
          isFirst = false;
        });
      }
    }

    if (selectedValue != null) {
      res2 =
          await ref.read(stateProvider.notifier).getState(token, selectedValue);
      if (this.mounted) {
        setState(() {});
      }
    }
    res1 = await ref.read(countryProvider.notifier).getCountry(token);
    print(res1);
    if (this.mounted) {
      setState(() {});
    }
  }

  String dropdownValue = 'india';

  var countrys = [
    "india",
    "pakistan",
    "america",
    "paris",
  ];

  var globalKey = GlobalKey<FormState>();
  var name, address, city, state, zipcode, country;
  var selectedValue1;
  var dataList = [];
  var stateList = [];
  var selectedValue;
  void setValidate() {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      print(name);
      if (id != 'add') {
        var update = ref.read(updateAddressProvider.notifier).updatedAddress(
            token, id, name, address, city, state, zipcode, country);
        Navigator.pop(context, true);
      }
      if (id == 'add') {
        Navigator.pop(context, {
          'firstName': name,
          'address1': address,
          'city': city,
          'state': selectedValue1,
          'postcode': zipcode,
          'country': selectedValue
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiData = ref.read(getSingleAddressProvider.notifier).singleAddress;
    final countryData = ref.read(countryProvider.notifier).country;
    final data = countryData == null ? null : countryData['result']['data'];
    final stateData = ref.read(stateProvider.notifier).stateCity;
    final data2 = stateData == null ? null : stateData['result']['data'];
    stateList = stateData == null ? [] : data2;
    data == null ? dataList = [] : dataList = data;

    return isLoader
        ? Scaffold(
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
              title: Center(child: Text('Adding Shipping Address')),
            ),
            body: Container(
              child: Form(
                  key: globalKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: TextFormField(
                                  initialValue: id == 'add'
                                      ? null
                                      : apiData['result']['addressData'][0]
                                          ['firstName'],
                                  style: const TextStyle(fontSize: 14),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: const Text(
                                      'FullName',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter the first name';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    name = value!;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: TextFormField(
                                  initialValue: id == 'add'
                                      ? null
                                      : apiData?['result']['addressData'][0]
                                          ['address1'],
                                  style: const TextStyle(fontSize: 14),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: const Text(
                                      'Address',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter the address';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    address = value!;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              // height: height*0.15,
                              // width: width*0.95,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: TextFormField(
                                  initialValue: id == 'add'
                                      ? null
                                      : apiData?['result']['addressData'][0]
                                          ['city'],
                                  style: const TextStyle(fontSize: 14),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: const Text(
                                      'City',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter the city';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    city = value!;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: id != 'add'
                                    ? TextFormField(
                                        initialValue: apiData?['result']
                                            ['addressData'][0]['country'],
                                        style: const TextStyle(fontSize: 14),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            label: const Text(
                                              'country',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            )),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'Please enter the country code';
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          country = value!;
                                        },
                                      )
                                    : DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            label: Text(
                                              'country',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            )),
                                        value: selectedValue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedValue = newValue;
                                            api();
                                            print(selectedValue);
                                          });
                                        },
                                        items: dataList.map((value) {
                                          return DropdownMenuItem(
                                            value: value['id'].toString(),
                                            child: Text(
                                                '${value['code']} ${value['name']}'
                                                    .toString()),
                                          );
                                        }).toList(),
                                      ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              // height: height*0.15,
                              // width: width*0.95,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: id != 'add'
                                    ? TextFormField(
                                        initialValue: apiData?['result']
                                            ['addressData'][0]['state'],
                                        style: const TextStyle(fontSize: 14),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          label: const Text(
                                            'State/Province/Region',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'Please enter the state';
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          state = value!;
                                        },
                                      )
                                    : DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            label: Text(
                                              'state',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            )),
                                        value: selectedValue1,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedValue1 = newValue;
                                            api();
                                            print(selectedValue1);
                                          });
                                        },
                                        items: stateList.map((value) {
                                          return DropdownMenuItem(
                                            value: value['id'].toString(),
                                            child: Text(
                                                '${value['defaultName']} '
                                                    .toString()),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'Please enter the state';
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          selectedValue1 = value!;
                                        },
                                      ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: TextFormField(
                                  initialValue: id == 'add'
                                      ? null
                                      : apiData?['result']['addressData'][0]
                                          ['postcode'],
                                  style: const TextStyle(fontSize: 14),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: const Text(
                                      'Zip Code(Postal Code)',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter the zip code';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    zipcode = value!;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: TextButton(
                                onPressed: setValidate,
                                child: Text(
                                  'SAVE ADDRESS',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
  }
}
