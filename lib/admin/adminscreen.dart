

import 'package:betaecommerce/admin/additem.dart';
import 'package:betaecommerce/admin/manage.dart';
import 'package:betaecommerce/admin/vieworders.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static String admScreenid = "AdmScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(child: Image.asset("assets/images/adm.png")),

          buildMenuItem(context, Addproduct.id, "add product"),
         buildMenuItem(context, Manage.id, "Edit products"),
         buildMenuItem(context, ViewOrderScreen.id, "view products")
        ]),
      ),
    );
  }



  Widget buildMenuItem(BuildContext context, String path,String text) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(path);
      },
      child: Container(
       // margin: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(30, 6, 30, 0),
        decoration: BoxDecoration(
          color: Color(0xff3F3D56),
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.infinity,
        child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade50),),
      ),
    );
  }
}
