import 'package:flutter/material.dart';
import 'package:mangoit_ecart/provider/shippmentMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/authprovider.dart';
import '../provider/createOrder.dart';
import '../provider/customerIDProvider.dart';
import '../provider/getCart.dart';
import 'package:url_launcher/url_launcher.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({super.key});

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  var name, address, city, zipcode, state, country;
  var shipData;
  var cartData;
  var id, token, res, shipRes;
  var cardNumber;
  var newString, newString2;
  var cardNo;
  var cardDate;
  var cardCvv;
  var methodTitle;
  var paymentMethod;
  var newString3;
  var total;
  var gTotal;
  var cTotal;
  var cardMonth;
  var cardYear;
  var err;
  var addAddress;
  var isLoader = false;
  var arr = [];

  bool isSelect = true;
  bool isAddress = true;
  _launchUrl(res) async {
    final Uri _url = Uri.parse(res);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
      print('navigate ');
      Future.delayed(
          Duration(seconds: 4),
          () => Navigator.pushNamedAndRemoveUntil(
              context, '/successpayment', (route) => route.isFirst));
    } else {
      print('Could not launch $_url');
    }
    // if (await canLaunchUrl( _url)){
    //   await launchUrl( _url);
    //   // Navigator.pushNamedAndRemoveUntil(
    //   //         context,
    //   //         '/successpayment',
    //   //             (route) => route.isFirst);
    // }
    // else {
    //   throw Exception('Could not launch $_url');
    // }
    // if (!await launchUrl(_url)) {
    //   throw Exception('Could not launch $_url');
    // }
    // Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     '/successpayment',
    //         (route) => route.isFirst);
  }

  void api() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    address = prefs.getString('address');
    city = prefs.getString('city');
    zipcode = prefs.getString('zipcode');
    state = prefs.getString('state');
    country = prefs.getString('country');
    print('name${name}');
    id = await ref.read(CustomerIdProvider.notifier).getId;
    print(id);
    token = await ref.read(providerResult.notifier).token;
    print(token);

    res = await ref.read(getCartProvider.notifier).getCart(token, id,context);
    shipRes = await ref.read(shippingProvider.notifier).getShippment(token);
    setState(() {});
  }

  void showSnackbar(BuildContext context, add) {
    final snackbar = SnackBar(
        backgroundColor: Colors.green,
        content: add == false
            ? Text('please select address')
            : err['isError'] == false || err.runtimeType == String
                ? Text('order placed successful')
                : Text('error${err['message'].toString()}'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  void initState() {
    arr.add('paypal');
    paymentMethod = "paypal";
    methodTitle = "paypal";
    cardMonth = "";
    cardYear = "";
    cardCvv = "";
    cardNo = "";
    api();
    // TODO: implement initState
    super.initState();
  }

  var changeAddress;
  var isCheck = false;

  @override
  Widget build(BuildContext context) {
    shipData = ref.read(shippingProvider.notifier).shipping;
    cartData = ref.read(getCartProvider.notifier).cart;
    // print(arr);
    print('ship${shipData}');
    print(cartData);
    return shipData == null && cartData == null
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                //replace with our own icon data.
              ),
              title: Center(child: Text('Checkout')),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                      child: Text(
                        'Shipping address',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      changeAddress = await Navigator.pushNamed(
                                          context, '/shoppingaddress',
                                          arguments: 'add');
                                      setState(() {});
                                    },
                                    // : null,
                                    child: Text(
                                      'Add new address',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      changeAddress = await Navigator.pushNamed(
                                          context, '/shipping');
                                      setState(() {});
                                    },
                                    // : null,
                                    child: Text(
                                      'Select address',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                            changeAddress == null
                                ? Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      '${changeAddress['firstName']}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                            changeAddress == null
                                ? Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      '${changeAddress['address1']}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                            changeAddress == null
                                ? Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, bottom: 15),
                                    child: Text(
                                      '${changeAddress['city']} ${changeAddress['state']} ${changeAddress['postcode']} ${changeAddress['country']}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: arr.contains('card')
                                      ? Colors.yellow.shade800
                                      : Colors.white,
                                  foregroundColor: arr.contains('card')
                                      ? Colors.white
                                      : Colors.black),
                              onPressed: () async {
                                arr = [];
                                arr.add("card");
                                cardNumber = await Navigator.pushNamed(
                                    context, '/payment');
                                print(cardNumber['cardNo']);
                                print(cardNumber.runtimeType);
                                newString = cardNumber['cardNo']
                                    .substring(cardNumber['cardNo'].length - 5);
                                newString2 = cardNumber['expiryDate'].substring(
                                    cardNumber['expiryDate'].length - 2);

                                newString3 =
                                    cardNumber['expiryDate'].substring(0, 2);
                                print('month${newString3}');
                                print('year${newString2}');
                                print(cardNumber['expiryDate']);
                                cardNo = cardNumber['cardNo'];
                                cardCvv = cardNumber['cvv'];
                                cardYear = newString2;
                                cardMonth = newString3;
                                methodTitle = "stripe";
                                paymentMethod = "stripe";

                                setState(() {
                                  // _hasBeenPressed = true;
                                });
                              },
                              child: Text('card payment')),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: arr.contains('paypal')
                                      ? Colors.yellow.shade800
                                      : Colors.white,
                                  foregroundColor: arr.contains('paypal')
                                      ? Colors.white
                                      : Colors.black),
                              onPressed: () {
                                paymentMethod = "paypal";
                                methodTitle = "paypal";
                                cardMonth = "";
                                cardYear = "";
                                cardCvv = "";
                                cardNo = "";
                                arr = [];
                                arr.add("paypal");
                                setState(() {});
                              },
                              child: Text('paypal')),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: arr.contains('cash')
                                      ? Colors.yellow.shade800
                                      : Colors.white,
                                  foregroundColor: arr.contains('cash')
                                      ? Colors.white
                                      : Colors.black),
                              onPressed: () {
                                methodTitle = "cod";
                                paymentMethod = "cod";
                                cardMonth = "";
                                cardYear = "";
                                cardCvv = "";
                                cardNo = "";
                                // arr.add('cash');
                                arr = [];

                                arr.add('cash');

                                setState(() {});
                              },
                              child: Text('cash on delivery')),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Delivery method',
                      style: TextStyle(fontSize: 16),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/card2.png'),
                          Image.asset('assets/card3.png'),
                          Image.asset('assets/card1.png'),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        shipData == null
                            ? Text('')
                            : Text(
                                '${shipData['result']['data'][0]['base_price']}\$')
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        cartData == null
                            ? Text('')
                            : Text(
                                '${cartData['result']['data']['grandTotal']}\$') //
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Summary',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        shipData == null || cartData == null
                            ? Text('')
                            : Text(
                                '${(int.parse('${cartData['result']['data']['grandTotal']}') + int.parse('${shipData['result']['data'][0]['base_price']}')).toString()}\$')
                      ],
                    ),
                    SizedBox(
                      height: 15,
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
                        onPressed: () async {
                          if (changeAddress != null) {
                            setState(() {
                              isLoader = true;
                            });
                            err = await ref
                                .read(orderProvider.notifier)
                                .getOrder(
                                    token,
                                    changeAddress['address1'],
                                    cardNo,
                                    cardMonth,
                                    cardYear,
                                    cardCvv,
                                    changeAddress['city'],
                                    changeAddress['country'],
                                    id,
                                    changeAddress['email'],
                                    changeAddress['firstName'],
                                    cartData['result']['data']['grandTotal'],
                                    changeAddress['phone'],
                                    changeAddress['postcode'],
                                    changeAddress['state'],
                                    methodTitle,
                                    paymentMethod);
                            setState(() {
                              isLoader = false;
                            });
                            print(err.runtimeType);
                            print(err);
                            err.runtimeType == String ? _launchUrl(err) : null;

                            showSnackbar(context, true);

                            err.runtimeType == String
                                ? null
                                : err['isError'] == false
                                    ? Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/successpayment',
                                        (route) => route.isFirst) //back

                                    : null;
                          }

                          if (changeAddress == null) {
                            showSnackbar(context, false);
                            setState(() {});
                          }
                        },
                        child: isLoader
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Text(
                                'SUBMIT ORDER',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
