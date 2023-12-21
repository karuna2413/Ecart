import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangoit_ecart/provider/getUser.dart';
import '../provider/authprovider.dart';

class MyProfile extends ConsumerStatefulWidget {
  const MyProfile({super.key});

  @override
  ConsumerState<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends ConsumerState<MyProfile> {
  var res;
  var stateData;
  var token;
  void api() async {
    token = await ref.read(providerResult.notifier).token;
    print('token${token}');
    // if(token==null){
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, "/signup", (Route<dynamic> route) => false);
    // }
    // else{
    //   res = await ref.read(userProvider.notifier).getUser(token);
    //
    // }
    res = await ref.read(userProvider.notifier).getUser(token,context);

    print('myprofile res${res}');
  }

  @override
  void initState() {
    api();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stateData = ref.watch(userProvider);
    // if(stateData=='token is required/login again'){
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, "/signup", (Route<dynamic> route) => false);
    //
    // }

    return stateData['result'] == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0, left: 20),
                child: Text(
                  'My profile',
                  style: TextStyle(fontSize: 34, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '${stateData['result']['data']['firstName']} ${stateData['result']['data']['lastName']}'),
                          Text('${stateData['result']['data']['email']}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My orders',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Already have 12 orders',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/myOrder');
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Notifications,password',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Logout user',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/logout');
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                        ))
                  ],
                ),
              )
            ],
          );
  }
}
