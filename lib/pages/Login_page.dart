import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/provider/Provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  var check, check1;

  var isLoader = false;
  var globalKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var err;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode1.addListener(() {
      setState(() {});
    });
    focusNode2.addListener(() {
      setState(() {});
    });
  }

  void setValidate() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setState(() {
        isLoader = true;
      });
      var res = await ref
          .read(apiProvider.notifier)
          .loginApi({'email': email, 'password': password});

      setState(() {
        isLoader = false;
      });
      if (res.statusCode == 200) {
        print('login successfull');
        globalKey.currentState!.reset();
        check = null;
        check1 = null;
        final result = json.decode(res.body);

        Navigator.pushNamedAndRemoveUntil(
            context, "/mainscreen", (Route<dynamic> allRoutes) => false);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('login successful')));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['result']['token']);
        await prefs.setInt('id', result['result']['user']['id']);

        print(result['result']['token']);
      } else {
        print('not valid');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('email & password not valid')));
        check = null;
        check1 = null;
      }
    }
  }

  @override
  void dispose() {
    focusNode1.removeListener(() {});
    focusNode1.dispose();
    focusNode2.removeListener(() {});
    focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: Image.asset('assets/main.png'),
                        ),
                        const Positioned(
                            left: 20,
                            bottom: 0,
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 34),
                            ))
                      ],
                    ),
                  ),
                  Form(
                    key: globalKey,
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 50),
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 5),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    focusNode: focusNode1,
                                    decoration: InputDecoration(
                                      suffixIcon: Visibility(
                                          visible: !focusNode1.hasFocus,
                                          child: check == null
                                              ? const Text('')
                                              : check == false
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )
                                                  : const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )),
                                      border: InputBorder.none,
                                      label: const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == '') {
                                        check = true;

                                        return 'Please enter the email';
                                      }

                                      if (!RegExp(r'\S+@\S+\.\S+')
                                          .hasMatch(value!)) {
                                        check = true;

                                        return 'Please enter the valid email address';
                                      }
                                      check = false;

                                      return null;
                                    },
                                    onSaved: (value) {
                                      check = false;

                                      email = value!;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 5),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    focusNode: focusNode2,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      suffixIcon: Visibility(
                                          visible: !focusNode2.hasFocus,
                                          child: check1 == null
                                              ? const Text('')
                                              : check1 == false
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )
                                                  : const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )),
                                      border: InputBorder.none,
                                      label: const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == '') {
                                        check1 = true;
                                        return 'Please enter the password';
                                      }
                                      if (value!.trim().length < 6) {
                                        check1 = true;
                                        return 'Minimum 6 digits are required';
                                      }
                                      check1 = false;
                                      return null;
                                    },
                                    onSaved: (value) {
                                      check1 = false;
                                      password = value!;
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Forgot your password? ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forgotpassword');
                                      },
                                      icon: const Icon(Icons.arrow_right_alt,
                                          color: Colors.red))
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: width,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: setValidate,
                                  child: isLoader
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.white))
                                      : const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                ),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                title: Text(''),
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.transparent
                    .withOpacity(0),
                elevation: 0.0,
              ),
            ),
          ],
        ));
  }
}
