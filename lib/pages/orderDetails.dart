import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/widgets/orderDetailCard.dart';

import '../provider/authprovider.dart';
import '../provider/cancleOrder.dart';
import '../provider/orderInfo.dart';

class OrderDetails extends ConsumerStatefulWidget {
  const OrderDetails({super.key});

  @override
  ConsumerState<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends ConsumerState<OrderDetails> {
  var id;
  var res;
  var token;
  var state;
  var status;
  var btn;
  var check = true;
  var or;
  bool isPressed = false;

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
    id = args['id'].toString();
    status = args['status'].toString();
    btn = args['check'].toString();
    print(btn);
    api(id);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void api(id) async {
    token = await ref.read(providerResult.notifier).token;
    res = await ref.read(orderInfoProvider.notifier).order(id, token);
    print(res);
  }

  void showSnackbar(BuildContext context) {
    final snackbar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Order cancel successful'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(orderInfoProvider);
    return state['result'] == null
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
            appBar: AppBar(
              title: Center(child: Text('Order Details')),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                //replace with our own icon data.
              ),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15, left: 25, right: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order No: ${id}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          state['result']['data'][0]['createdAt']
                              .substring(0, 10),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            status,
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Text(
                        '${state['result']['data'][0]['totalQtyOrdered'].toString()} Items'),
                    Container(
                      height:
                          state['result']['data'][0]['OrderTransaction'] == null
                              ? MediaQuery.of(context).size.height * 0.6
                              : MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount:
                              state['result']['data'][0]['OrderItems'].length,
                          itemBuilder: (context, index) {
                            return orderDetailCard(
                                name: state['result']['data'][0]['OrderItems']
                                    [index]['name'],
                                amnt: state['result']['data'][0]['OrderItems']
                                        [index]['total']
                                    .toString(),
                                qt: state['result']['data'][0]['OrderItems']
                                        [index]['qtyOrdered']
                                    .toString());
                          }),
                    ),
                    state['result']['data'][0]['OrderTransaction'] == null
                        ? Text('')
                        : Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Order information',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Payment methode: ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Spacer(),
                                      Text(
                                        '**** **** **** ${state['result']['data'][0]['OrderTransaction']['cardLastFour']}',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery methode: ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${state['result']['data'][0]['OrderTransaction']['type']}',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Amount: ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${state['result']['data'][0]['grandTotal'].toString()}\$',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    btn == 'cancle'
                        ? Text('')
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: isPressed
                                    ? Colors.orange.shade700
                                    : Colors.white,
                                foregroundColor:
                                    isPressed ? Colors.white : Colors.black),
                            onPressed: () async {
                              if (check == true) {
                                or = await ref
                                    .read(cancleOrderProvider.notifier)
                                    .cnclOrder(id, token);
                                print(or);
                              }
                              check = false;

                              showSnackbar(context);
                              if (or['isError'] == false) {
                                Navigator.pop(context, 'true');
                              }
                            },
                            child: Text('Cancel order')),
                  ],
                ),
              ),
            ),
          );
  }
}
