import 'package:flutter/material.dart';

class OrdersCard extends StatefulWidget {
  OrdersCard(
      {required this.customCall,
      required this.qtd,
      required this.amnt,
      required this.oNo,
      required this.date,
      required this.status,
      required this.check});
  var oNo;
  var date;
  var status;
  var qtd;
  var amnt;
  var check;
  final VoidCallback? customCall;

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18, top: 18, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order No:${widget.oNo}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.date.substring(0, 10),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18, top: 0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Quantity:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    widget.qtd,
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    'Total Amount:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    '${widget.amnt}\$',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                            context, '/orderDetail', arguments: {
                          'id': widget.oNo,
                          'status': widget.status,
                          'check': widget.check
                        });
                        print(result);
                        if (result == 'true') {
                          widget.customCall!();
                          print('callback');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.black)),
                      child: Text(
                        'Details',
                        style: TextStyle(color: Colors.black),
                      )),
                  Text(
                    widget.status,
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
