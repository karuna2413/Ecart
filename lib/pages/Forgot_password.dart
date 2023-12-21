import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:mangoit_ecart/provider/Provider.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final FocusNode focusNode1 = FocusNode();
  var check;
  var res;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode1.addListener(() {
      setState(() {});
    });
  }

  var isLoader = false;
  var globalKey = GlobalKey<FormState>();
  var email = '';
  var result;
  void setValidate() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setState(() {
        isLoader = true;
      });
      res = await ref.read(apiProvider.notifier).forgotpassApi(email);
      setState(() {
        isLoader = false;
      });
      print(res);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: res['isError'] == true
              ? Text('${res['message']}')
              : Text('${res['result']}')));
    }
  }

  @override
  void dispose() {
    focusNode1.removeListener(() {});
    focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                child: Stack(
                  children: [
                    ClipRRect(
                      child: Image.asset('assets/main.png'),
                    ),
                    const Positioned(
                        left: 20,
                        bottom: 0,
                        child: Text(
                          'Forgot Password',
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
                            child: const Text(
                                'Please enter your email address,you will receive a link to create a new password via email.')),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: TextFormField(
                              autofocus: false,
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
                                  return 'required';
                                }

                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
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
                          // height:  height*0.1,
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
                                    color: Colors.white,
                                  ))
                                : const Text(
                                    'Send',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                .withOpacity(0), //You can make this transparent
            elevation: 0.0, //No shadow
          ),
        ),
      ]),
    );
  }
}
