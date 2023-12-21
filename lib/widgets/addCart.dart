import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/config/Config.dart';
import 'package:mangoit_ecart/provider/deleteCart.dart';
import 'package:mangoit_ecart/provider/deleteItem.dart';
import '../provider/CartProvider.dart';
import '../provider/authprovider.dart';
import '../provider/customerIDProvider.dart';
import '../provider/getCart.dart';

class addCart extends ConsumerStatefulWidget {
  addCart({super.key});

  @override
  ConsumerState<addCart> createState() => _addCartState();
}

class _addCartState extends ConsumerState<addCart> {
  var count = 1;
  var res, id, token;
  var addRes;
  var refreshRes;
  var removeRes;
  var removeItem;
  var isLoad = false;
  void api() async {
    id = await ref.read(CustomerIdProvider.notifier).getId;

    token = await ref.read(providerResult.notifier).token;
    print('token${token}');

      res = await ref.read(getCartProvider.notifier).getCart(token, id,context);

      setState(() {});


  }

  @override
  void initState() {
    api();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final res1 = ref.read(getCartProvider.notifier).cart;
    print(res);

    return res == null || isLoad == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : res1['result']['data'] == null
            ? Center(
                child: Text('no items in cart'),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: res1['result']['data']['CartItems'].length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.27,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.19,
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        child: Image.network(
                                            '${baseUrl + res1['result']['data']['CartItems'][index]['Product']['ProductImages'][0]['path']}')),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                res1['result']['data']
                                                        ['CartItems'][index]
                                                    ['name'],
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              PopupMenuButton(
                                                onSelected: (value) {},
                                                itemBuilder: (BuildContext bc) {
                                                  return [
                                                    PopupMenuItem(
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (context) =>
                                                                    AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          'Confirm Delete Product',
                                                                        ),
                                                                        content:
                                                                            Text(
                                                                          'Are you sure, you want to delete this product',
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(backgroundColor: Colors.red),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: Text('No',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                )),
                                                                          ),
                                                                          TextButton(
                                                                              style: TextButton.styleFrom(backgroundColor: Colors.green),
                                                                              onPressed: () async {
                                                                                removeItem = await ref.read(deleteItemProvider.notifier).deleteItem(res1['result']['data']['CartItems'][index]['id'], token);
                                                                                refreshRes = await ref.read(getCartProvider.notifier).getCart(token, id,context);
                                                                                setState(() {});

                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                    backgroundColor: Colors.green,
                                                                                    content: Text(
                                                                                      'cart item deleted successful',
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    )));
                                                                                // Navigator.pop(context, true)
                                                                              },
                                                                              child: Text('Yes',
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ))),
                                                                        ]));
                                                          },
                                                          child: Text(
                                                            'Delete from the list',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                      // value: '/hello',
                                                    ),
                                                  ];
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Color:',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              'Black',
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Text(
                                              'Size:',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              'L',
                                              style: TextStyle(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0, top: 5),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                child: FloatingActionButton(
                                                    heroTag: "btn1",
                                                    backgroundColor:
                                                        Colors.white70,
                                                    shape: CircleBorder(
                                                        side: BorderSide.none),
                                                    onPressed: () async {
                                                      setState(() {
                                                        isLoad = true;
                                                      });
                                                      if (res1['result']['data']
                                                                      [
                                                                      'CartItems']
                                                                  [index]
                                                              ['quantity'] <=
                                                          1) {
                                                      } else {
                                                        removeRes = await ref
                                                            .read(
                                                                deleteCartProvider
                                                                    .notifier)
                                                            .deleteCart(
                                                                token,
                                                                res1['result'][
                                                                            'data']
                                                                        [
                                                                        'CartItems']
                                                                    [
                                                                    index]['id']);
                                                        refreshRes = await ref
                                                            .read(
                                                                getCartProvider
                                                                    .notifier)
                                                            .getCart(token, id,context);
                                                        setState(() {
                                                          isLoad = false;
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.grey,
                                                    )),
                                              ),
                                            ),
                                            isLoad
                                                ? CircularProgressIndicator()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10),
                                                    child: Text(res1['result']
                                                                    ['data']
                                                                ['CartItems']
                                                            [index]['quantity']
                                                        .toString()),
                                                  ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0, top: 5),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                child: FloatingActionButton(
                                                    heroTag: "btn2",
                                                    backgroundColor:
                                                        Colors.white70,
                                                    shape: CircleBorder(
                                                        side: BorderSide.none),
                                                    onPressed: () async {
                                                      setState(() {
                                                        isLoad = true;
                                                      });
                                                      addRes = await ref
                                                          .read(cartProvider
                                                              .notifier)
                                                          .cartapi(
                                                              id,
                                                              res1['result']['data']
                                                                          ['CartItems']
                                                                      [index]
                                                                  ['productId'],
                                                              res1['result']['data']
                                                                          ['CartItems']
                                                                      [index]
                                                                  ['productId'],
                                                              '1',
                                                              token);

                                                      refreshRes = await ref
                                                          .read(getCartProvider
                                                              .notifier)
                                                          .getCart(token, id,context);
                                                      setState(() {
                                                        isLoad = false;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.grey,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                            ),
                                            Text(
                                                '\$${res1['result']['data']['CartItems'][index]['price']}')
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          res1['result']['data'] == null
                              ? Text('')
                              : Text(
                                  'Total Amount :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          Text('${res1['result']['data']['grandTotal']}\$')
                        ],
                      ),
                    ),
                    res1['result']['data'] == null
                        ? Text('')
                        : Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/checkout');
                                },
                                child: Text(
                                  'CHECK OUT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              );
  }
}
