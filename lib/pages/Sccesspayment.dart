import 'package:flutter/material.dart';

class SccessPayment extends StatefulWidget {
  const SccessPayment({super.key});

  @override
  State<SccessPayment> createState() => _SccessPaymentState();
}

class _SccessPaymentState extends State<SccessPayment> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, "/mainscreen", (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child:
                  Image.asset(alignment: Alignment.center, 'assets/bags.png'),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Success!',
                style: TextStyle(fontSize: 34),
              ),
            )),
            Center(
              child: Text(
                'Your order will be deliverd soon.',
                style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
              ),
            ),
            Center(
              child: Text(
                'Thank you for choosing our app!',
                style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/mainscreen", (Route<dynamic> route) => false);
                },
                child: Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
