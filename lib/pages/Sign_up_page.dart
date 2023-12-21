import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mangoit_ecart/provider/Provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();

  var check, check1, check2, check3, check4;
  var isLoader = false;
  var globalKey = GlobalKey<FormState>();
  var name = '';
  var email = '';
  var password = '';
  var lastname = '';
  var mobile = '';
  TextEditingController _pass = TextEditingController();
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
    focusNode3.addListener(() {
      setState(() {});
    });
    focusNode4.addListener(() {
      setState(() {});
    });
    focusNode5.addListener(() {
      setState(() {});
    });
  }

  void setValidate() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setState(() {
        isLoader = true;
      });
      var ress = await ref.read(apiProvider.notifier).signupApi({
        'name': name,
        'lastname': lastname,
        'email': email,
        'password': password
      });

      setState(() {
        isLoader = false;
      });
      if (ress.statusCode == 201) {
        print('sing up successfull');
        globalKey.currentState!.reset();
        _pass.clear();

        check = null;
        check1 = null;
        check2 = null;
        check3 = null;
        check4 = null;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful')));
        Navigator.pushNamed(context, '/login');
      } else {
        print('not valid');
        check = null;
        check1 = null;
        check2 = null;
        check3 = null;
        check4 = null;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('email already exist')));
      }
      var responsed = await http.Response.fromStream(ress);
      print(responsed);
      final responseData = json.decode(responsed.body);
      print(responseData);
    }
  }

  @override
  void dispose() {
    focusNode1.removeListener(() {});
    focusNode1.dispose();
    focusNode2.removeListener(() {});
    focusNode2.dispose();
    focusNode3.removeListener(() {});
    focusNode3.dispose();
    focusNode4.removeListener(() {});
    focusNode4.dispose();
    focusNode5.removeListener(() {});
    focusNode5.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      body: SingleChildScrollView(
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
                        'Sign up',
                        style: TextStyle(fontSize: 34),
                      ))
                ],
              ),
            ),
            Form(
              key: globalKey,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        // height: height*0.15,
                        // width: width*0.95,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14),
                            focusNode: focusNode1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                'FirstName',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            validator: (value) {
                              if (value == '') {
                                check = true;
                                return 'Please enter the first name';
                              }
                              check = false;

                              return null;
                            },
                            onSaved: (value) {
                              check = false;

                              name = value!;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        // height: height*0.15,
                        // width: width*0.95,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14),
                            focusNode: focusNode2,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                'LastName',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            validator: (value) {
                              if (value == '') {
                                check1 = true;

                                return 'Please enter the last name';
                              }
                              check1 = false;

                              return null;
                            },
                            onSaved: (value) {
                              check1 = false;

                              lastname = value!;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: focusNode3,
                            decoration: InputDecoration(
                              suffixIcon: Visibility(
                                  visible: !focusNode3.hasFocus,
                                  child: check2 == null
                                      ? const Text('')
                                      : check2 == false
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
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            validator: (value) {
                              if (value == ' ') {
                                check2 = true;

                                return 'Please enter the email';
                              }

                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                                check2 = true;

                                return 'Please enter the valid email address';
                              }
                              check2 = false;

                              return null;
                            },
                            onSaved: (value) {
                              check2 = false;

                              email = value!;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: TextFormField(
                            controller: _pass,
                            style: const TextStyle(fontSize: 14),
                            focusNode: focusNode4,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: Visibility(
                                  visible: !focusNode4.hasFocus,
                                  child: check3 == null
                                      ? const Text('')
                                      : check3 == false
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
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            validator: (value) {
                              if (value == '') {
                                check3 = true;

                                return 'Please enter the password';
                              }
                              if (value!.trim().length < 6) {
                                check3 = true;

                                return 'Minimum 6 digits are required';
                              }
                              check3 = false;

                              return null;
                            },
                            onSaved: (value) {
                              check3 = false;

                              password = value!;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            focusNode: focusNode5,
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: Visibility(
                                  visible: !focusNode5.hasFocus,
                                  child: check4 == null
                                      ? const Text('')
                                      : check4 == false
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
                                'Confirm Password',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            validator: (value) {
                              if (value == '') {
                                check4 = true;

                                return 'Please enter the confirm password';
                              }
                              if (value != _pass.text) {
                                check4 = true;
                                return 'Password & Confirm password do not match';
                              }
                              check4 = false;

                              return null;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  icon: const Icon(Icons.arrow_right_alt,
                                      color: Colors.red)))
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
                                  'SIGN UP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
