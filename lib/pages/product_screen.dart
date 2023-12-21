import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/provider/CartProvider.dart';
import 'package:mangoit_ecart/provider/customerIDProvider.dart';
import 'package:mangoit_ecart/provider/productDetails.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../config/Config.dart';
import '../widgets/ProductCard.dart';
import 'package:html/parser.dart';
import 'package:mangoit_ecart/provider/authprovider.dart';

class ProductScreen extends ConsumerStatefulWidget {
  ProductScreen({super.key});
  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  CarouselController carouselController = CarouselController();

  var count = true;
  String? parsedstring;
  var arg, res;
  var isCart = false;
  var id;
  var token;
  late Map imgMap;
  var cartRes;
  var isLoader = false;
  void showSnackbar(BuildContext context, err) {
    final snackbar = SnackBar(
        backgroundColor: Colors.green,
        content: err['isError'] == true
            ? Text('${err['message']}')
            : Text('${err['result']['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  //bug
  void didChangeDependencies() {
    arg = ModalRoute.of(context)?.settings?.arguments;
    print(arg);
    api();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void api() async {
    if (mounted) {
      await ref.read(productDetailProvider.notifier).getProductDetail(arg);
      await ref.read(CustomerIdProvider.notifier).getUserId();
      token = await ref.read(providerResult.notifier).token;
    }
  }

  @override
  Widget build(BuildContext context) {
    id = ref.watch(CustomerIdProvider);

    res = ref.watch(productDetailProvider);
    if (res != null) {
      var doc = parse(res['result']['productData']['ProductFlat']['description']
          .toString());
      if (doc.documentElement != null) {
        parsedstring = doc.documentElement!.text;
      }
    }

    return res == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              willPop(context);

              return false;
            }
            // willPop

            ,
            child: Scaffold(
                backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        willPop(context);
                        print('appbarback button');
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  title: Center(
                      child: Text(
                          res['result']['productData']['ProductFlat']['name'])),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CarouselSlider(
                                  carouselController:
                                      carouselController, // Give the controller

                                  items: [
                                    ...res['result']['productData']
                                            ['ProductImages']
                                        .map(
                                      (e) => Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0, bottom: 30),
                                            child: Image.network(
                                                '${baseUrl + e['path']}'),
                                          )),
                                    )
                                  ],
                                  options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.39,
                                      autoPlay: false,
                                      autoPlayCurve: Curves.easeInOut,
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 500),
                                      aspectRatio: 16 / 9)),
                              Positioned(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.15,
                                left: MediaQuery.of(context).size.height * 0.08,
                                child: IconButton(
                                  onPressed: () {
                                    carouselController.previousPage();
                                  },
                                  icon: Icon(Icons.keyboard_arrow_left_sharp),
                                ),
                              ),
                              Positioned(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.15,
                                right:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: IconButton(
                                  onPressed: () {
                                    carouselController.nextPage();
                                  },
                                  icon: Icon(Icons.keyboard_arrow_right),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  res['result']['productData']['ProductFlat']
                                      ['name'],
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                    '\$${res['result']['productData']['ProductFlat']['price']}.00',
                                    style: TextStyle(fontSize: 24))
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade800,
                                ),
                                Icon(Icons.star, color: Colors.yellow.shade800),
                                Icon(Icons.star, color: Colors.yellow.shade800),
                                Icon(Icons.star, color: Colors.yellow.shade800),
                                Icon(Icons.star_border,
                                    color: Colors.yellow.shade800)
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Size',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                    res['result']['productData']['ProductFlat']
                                            ['size']
                                        .toString(),
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Text(parsedstring!),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow.shade800),
                                  onPressed: () async {
                                    // if(count==true){
                                    print('token${token}');
                                    if(token==null){
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/signup", (Route<dynamic> route) => false);
                                    }
                                    else{
                                      setState(() {
                                        isLoader = true;
                                      });

                                      cartRes = await ref
                                          .read(cartProvider.notifier)
                                          .cartapi(id, arg, null, '1', token);
                                      if (mounted) {
                                        setState(() {
                                          isLoader = false;
                                        });
                                      }
                                      count = false;
                                      print('cartres$cartRes');
                                      if(cartRes=='unauth'){
                                        setState(() {

                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) =>

                                             AlertDialog(
                                              title: Text('Please Login for add items'),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.pushNamedAndRemoveUntil(
                                                      context, "/signup", (Route<dynamic> route) => false);
                                                }, child: Text('Login')),
                                                TextButton(onPressed: (){}, child: Text('No')),

                                              ],
                                            ),);




                                      }
                                      else{
                                        showSnackbar(context, cartRes);

                                      }

                                      isCart = true;
                                      setState(() {});
                                    }

                                  },
                                  child: isLoader == true
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text('Add TO CART')),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Text(
                              'You can also like this',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: ProductCard(
                                    value: '50%',
                                    color: Colors.yellow.shade800),
                              )),
                        ]),
                  ),
                )));
  }

  willPop(BuildContext context) {
    print('willpop function');
    Navigator.popUntil(context, (route) => route.isFirst);
    // return Future.value(false);

// return true;
  }
}
