import 'package:flutter/material.dart';
import 'package:mangoit_ecart/pages/AddShoppingAddress.dart';
import 'package:mangoit_ecart/pages/Catelog_Screen.dart';
import 'package:mangoit_ecart/pages/Filter_Screen.dart';
import 'package:mangoit_ecart/pages/Forgot_password.dart';
import 'package:mangoit_ecart/pages/Login_page.dart';
import 'package:mangoit_ecart/pages/Logout.dart';
import 'package:mangoit_ecart/pages/Main_Screen.dart';
import 'package:mangoit_ecart/pages/MyBag.dart';
import 'package:mangoit_ecart/pages/Myprofile.dart';
import 'package:mangoit_ecart/pages/Payment.dart';
import 'package:mangoit_ecart/pages/Sccesspayment.dart';
import 'package:mangoit_ecart/pages/Shopping_Address.dart';
import 'package:mangoit_ecart/pages/Sign_up_page.dart';
import 'package:mangoit_ecart/pages/myOrder.dart';
import 'package:mangoit_ecart/pages/product_screen.dart';
import 'package:mangoit_ecart/pages/MybagCheckout.dart';
import '../pages/orderDetails.dart';
import '../pages/settings.dart';

var allRoutes = {
  '/signup': (BuildContext context) => SignUp(),
  '/shipping': (BuildContext context) => AddShoppingAddress(),
  '/login': (BuildContext context) => Login(),
  '/forgotpassword': (BuildContext context) => ForgotPassword(),
  '/mainscreen': (BuildContext context) => MainScreen(),
  '/catelog': (BuildContext context) => CatelogScreen(),
  '/product': (BuildContext context) => ProductScreen(),
  '/filter': (BuildContext context) => FilterScreen(),
  '/mybag': (BuildContext context) => MyBag(),
  '/checkout': (BuildContext context) => Checkout(),
  '/payment': (BuildContext context) => Payment(),
  '/shoppingaddress': (BuildContext context) => ShoppingAddress(),
  '/successpayment': (BuildContext context) => SccessPayment(),
  '/myprofile': (BuildContext context) => MyProfile(),
  '/logout': (BuildContext context) => Logout(),
  '/myOrder': (BuildContext context) => MyOrder(),
  '/orderDetail': (BuildContext context) => OrderDetails(),
  '/settings': (BuildContext context) => Settings(),
};
