import 'package:flutter/material.dart';

class orderDetailCard extends StatefulWidget {
  orderDetailCard({required this.name, required this.amnt, required this.qt});
  var name;
  var amnt;
  var qt;
  @override
  State<orderDetailCard> createState() => _orderDetailCardState();
}

class _orderDetailCardState extends State<orderDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Units: ${widget.qt}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '${widget.amnt}\$',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
