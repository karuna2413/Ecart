import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/authprovider.dart';
import '../provider/cancleOrder.dart';
import '../provider/getUser.dart';
import '../provider/setting.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  var res;
  var stateData;
  var updateRes;
  var globalKey = GlobalKey<FormState>();
  var oldPass;
  var newPass;
  @override
  void initState() {
    api();
    // TODO: implement initState
    super.initState();
  }

  void api() async {
    final token = await ref.read(providerResult.notifier).token;
    res = await ref.read(userProvider.notifier).getUser(token,context);
  }

  void setValidate() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      final token = await ref.read(providerResult.notifier).token;

      updateRes = await ref
          .read(settingProvider.notifier)
          .setting(cntrl1.text, cntrl2.text, token);

      Navigator.pop(context);
      showSnackbar(context, updateRes['isError'], updateRes['message']);

      globalKey.currentState!.reset();
      cntrl2.clear();
    }
  }

  void showSnackbar(BuildContext context, err, message) {
    final snackbar = SnackBar(
        backgroundColor: Colors.green,
        content: err == false
            ? Text('password changed successful')
            : Text('${message}'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  TextEditingController cntrl1 = TextEditingController();
  TextEditingController cntrl2 = TextEditingController();
  void modal() {
    showModalBottomSheet<dynamic>(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Password change',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              label: Text(
                                'Old Password',
                                style: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter the old password';
                              }
                            },
                            onSaved: (value) {
                              oldPass = value!;
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: TextFormField(
                            controller: cntrl2,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              label: Text(
                                'New Password',
                                style: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter the new password';
                              }
                            },
                            onSaved: (value) {
                              newPass = value!;
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text(
                                'Repeat New Password',
                                style: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter the  password';
                              }
                              if (value != cntrl2.text) {
                                return 'Password & Repeat password do not match';
                              }
                            },
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 15, bottom: 25),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextButton(
                        onPressed: setValidate,
                        child: Text(
                          'SAVE PASSWORD',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    stateData = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 34),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 0, top: 0, bottom: 0),
              child: Text(
                'Personal Information',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(left: 25, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FirstName',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(stateData['result']['data']['firstName'])
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(left: 25, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LastName',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(stateData['result']['data']['lastName'])
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 0, top: 0, bottom: 0),
                    child: Text(
                      'Password',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, top: 0, bottom: 0),
                    child: TextButton(
                      onPressed: () {
                        modal();
                      },
                      child: Text('Change',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(left: 28, top: 5),
                    child: TextField(
                      obscureText: true,
                      controller: TextEditingController(
                          text: stateData['result']['data']['password']),
                      decoration: InputDecoration(
                        label: Text('Password'),
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
