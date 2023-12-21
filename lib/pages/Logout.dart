import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        title: Center(child: Text('Logout ')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Logout User',
              style: TextStyle(fontSize: 34),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    foregroundColor: Colors.black),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  final token = await prefs.getString('token');
                  await prefs.remove('price1');
                  await prefs.remove('price2');
                  await prefs.remove('color');
                  await prefs.remove('active');
                  await prefs.remove('active1');
                  // print(token);
                  await prefs.remove('token');
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/signup", (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.logout),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('logout'),
                )),
          ),
        ],
      ),
    );
  }
}
