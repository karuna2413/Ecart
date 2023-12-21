import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:mangoit_ecart/config/Config.dart';

class CardList extends StatefulWidget {
  CardList(
      {required this.name,
      required this.price,
      required this.img,
      required this.des,
      required this.value,
      required this.color,
      required this.id});
  var name, price, img, value, color, id, des;

  @override
  State<CardList> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardList> {
  String? parsedstring;

  @override
  Widget build(BuildContext context) {
    if (widget.des != null) {
      var doc = parse(widget.des.toString());
      if (doc.documentElement != null) {
        parsedstring = doc.documentElement!.text;
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Stack(
            children: [
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
                top: 6,
                left: 6,
                child: Container(
                  height: 24,
                  width: 40,
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    widget.value.toString(),
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.46,
            color: Color.fromRGBO(249, 249, 249, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('\$${widget.price}.00',
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
