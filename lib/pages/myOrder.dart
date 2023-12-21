import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/widgets/OrdersCard.dart';
import '../provider/allUserOrder.dart';
import '../provider/authprovider.dart';

class MyOrder extends ConsumerStatefulWidget {
  const MyOrder({super.key});

  @override
  ConsumerState<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends ConsumerState<MyOrder> {
  var res;
  var allData;
  List data = [];
  var filterData;
  var successData;
  var token;
  var page = 1;
  var stateData;
  var totalCount;
  var check;
  var isLoader = false;
  var arr = [];

  void api() async {
    token = await ref.read(providerResult.notifier).token;

    res = await ref.read(userOrderProvider.notifier).userOrder(token);

    totalCount = res['result']['data']['count'];
    print(totalCount);
    allData = filterData = successData = res['result']['data']['rows'];
    print('alldata${allData}');
    data = allData;
    filterData =
        data.where((status) => status['status'] == 'cancelled').toList();
    successData =
        data.where((element) => element['status'] == 'succeeded').toList();

    setState(() {});
  }

  @override
  void initState() {
    arr.add('process');
    api();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: successData == null || isLoader == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: successData.length,
                  itemBuilder: (context, index) {
                    return OrdersCard(
                        qtd: successData[index]['totalQtyOrdered'].toString(),
                        amnt: successData[index]['grandTotal'].toString(),
                        oNo: successData[index]['id'].toString(),
                        date: successData[index]['createdAt'],
                        status: 'Processing',
                        check: 'deliver',
                        customCall: () {
                          setState(() {
                            isLoader = true;
                          });
                          api();
                          setState(() {
                            isLoader = false;
                          });
                        });
                  }),
        ));

    if (check == 'cancle') {
      content = Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: filterData == null || isLoader == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: filterData.length,
                    itemBuilder: (context, index) {
                      return filterData.length == 0
                          ? Center(
                              child: Text(
                              'no items',
                              style: TextStyle(color: Colors.black),
                            ))
                          : OrdersCard(
                              qtd: filterData[index]['totalQtyOrdered']
                                  .toString(),
                              amnt: filterData[index]['grandTotal'].toString(),
                              oNo: filterData[index]['id'].toString(),
                              date: filterData[index]['createdAt'],
                              status: 'Cancelled',
                              check: 'cancle',
                              customCall: () {
                                api();

                                // });
                              });
                    }),
          ));
    }

    if (check == 'success') {
      content = Text('');
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'My Orders',
                style: TextStyle(fontSize: 34),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: arr.contains('deliver')
                            ? Colors.black
                            : Colors.white),
                    onPressed: () {
                      arr = [];
                      arr.add('deliver');
                      setState(() {
                        check = 'success';
                      });
                    },
                    child: Text(
                      'Delivered',
                      style: TextStyle(
                          color: arr.contains('deliver')
                              ? Colors.white
                              : Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: arr.contains('process')
                            ? Colors.black
                            : Colors.white),
                    onPressed: () {
                      arr = [];
                      arr.add('process');
                      setState(() {
                        check = 'process';
                      });
                    },
                    child: Text(
                      'Processing',
                      style: TextStyle(
                          color: arr.contains('process')
                              ? Colors.white
                              : Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: arr.contains('cancel')
                            ? Colors.black
                            : Colors.white),
                    onPressed: () {
                      arr = [];
                      arr.add('cancel');
                      setState(() {
                        check = 'cancle';
                      });
                    },
                    child: Text(
                      'Cancelled',
                      style: TextStyle(
                          color: arr.contains('cancel')
                              ? Colors.white
                              : Colors.black),
                    )),
              ],
            ),
            content
          ],
        ),
      ),
    );
  }
}
