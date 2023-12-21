import 'package:flutter/material.dart';
import 'package:mangoit_ecart/config/Config.dart';

class CardWidget extends StatefulWidget {
  CardWidget(
      {required this.name,
      required this.price,
      required this.img,
      required this.value,
      required this.color,
      required this.id});
  var name, price, img, value, color, id;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          color: Color.fromRGBO(249, 249, 249, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                child: Text('\$${widget.price}.00',
                    style: TextStyle(color: Colors.red, fontSize: 14)),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/product',
                arguments: widget.id.toString());
          },
          child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: widget.img == null
                  ? Container(
                      height: 184,
                      width: 148,
                      decoration: BoxDecoration(color: Colors.white),
                    )
                  : Image.network('${baseUrl + widget.img}',
                      height: 184, width: 148, fit: BoxFit.fill)),
        ),
        Positioned(
          top: 7,
          left: 7,
          child: Container(
            height: 24,
            width: 40,
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              widget.value.toString(),
              style: TextStyle(fontSize: 11, color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}
