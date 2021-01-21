import 'package:betaecommerce/admin/edit.dart';
import 'package:betaecommerce/admin/manage.dart';
import 'package:betaecommerce/admin/vieworders.dart';
import 'package:betaecommerce/screens/HomeScreen.dart';
import 'package:betaecommerce/admin/additem.dart';
import 'package:betaecommerce/admin/adminscreen.dart';
import 'package:betaecommerce/screens/cartscreen.dart';
import 'package:betaecommerce/screens/login.dart';
import 'package:betaecommerce/screens/orderscreen.dart';
import 'package:betaecommerce/screens/signup.dart';
import 'package:betaecommerce/services/carteoperate.dart';
import 'package:betaecommerce/services/provideradmmodal.dart';
import 'package:betaecommerce/user/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/providermodal.dart';
main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return
           MultiProvider(
            providers: [
              ChangeNotifierProvider<ModalHud>(
                create: (context) => ModalHud(),
              ),
              ChangeNotifierProvider<CarteOperate>(
                create: (context) => CarteOperate(),
              ),

              ChangeNotifierProvider<AdmModal>(
                create: (context) => AdmModal(),
              )
            ],
            child: MaterialApp(
              home: isUserLoggedIn ? HomeScreen() : LoginScreen(),
              debugShowCheckedModeBanner: false,

              routes: {
                
                EditProduct.id:(context)=>EditProduct(),
                LoginScreen.id: (context) => LoginScreen(),
                Signup.signupId: (context) => Signup(),
                HomeScreen.homeScreenid: (context) => HomeScreen(),
                AdminScreen.admScreenid: (context) => AdminScreen(),
                Addproduct.id:(context)=>Addproduct(),
                Manage.id:(context)=>Manage(),
                ViewOrderScreen.id:(context)=>ViewOrderScreen(),
                ProductInfo.id:(context)=>ProductInfo(),
                CarteScreen.id:(context)=>CarteScreen(),
                OrderScreen.id:(context)=>OrderScreen(),

               // Background.id:(context)=>Background(),
              },
            ),
          );
        }

  }

